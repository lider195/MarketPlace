import Combine
import Firebase
import FirebaseFirestore
import Foundation

final class Shop: ObservableObject {
    @Published var shop = [ShopStruct]()

    @Published var name = ""
    @Published var surName = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var country = ""
    @Published var term = false
    @Published var isValid = false

    @Published var index = 2
    @Published var show = false

    var cancellable: Set<AnyCancellable> = []

    private var isNameShopPublisher: AnyPublisher<Bool, Never> {
        $name
            .map {
                $0.count > 3
            }
            .eraseToAnyPublisher()
    }

    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map {
                $0.contains("@") && $0.contains(".")
            }
            .eraseToAnyPublisher()
    }

    private var isITNValidPublisher: AnyPublisher<Bool, Never> {
        $phoneNumber
            .map {
                $0.count > 7
            }
            .eraseToAnyPublisher()
    }

    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isNameShopPublisher, isEmailValidPublisher, isITNValidPublisher, $term)
            .map { $0.0 && $0.1 && $0.2 && $0.3 }
            .eraseToAnyPublisher()
    }

    
    
    func addData(name: String,
                 surName: String,
                 phoneNumber: String,
                 email: String,
                 country: String)
    {
        let db = Firestore.firestore()
        db.collection("Shop").addDocument(data: ["name": name,
                                                 "surName": surName,
                                                 "phoneNumber": phoneNumber,
                                                 "email": email,
                                                 "country": country])
        { error in
            if error == nil {
                self.getData()
            } else {}
        }
    }

    func getData() {
        let db = Firestore.firestore()

        db.collection("Shop").getDocuments { completion, error in

            if error == nil {
                if let completion = completion {

                    DispatchQueue.main.async {
                        self.shop = completion.documents.map { d in

                            ShopStruct(id: d.documentID,
                                       name: d["name"] as? String ?? "",
                                       surName: d["surName"] as? String ?? "",
                                       phoneNumber: d["phoneNumber"] as? String ?? "",
                                       email: d["email"] as? String ?? "",
                                       country: d["country"] as? String ?? ""
                                       )
                        }
                    }
                }

            } else {}
        }
    }
}
