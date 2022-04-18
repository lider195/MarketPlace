import Combine
import Firebase
import FirebaseFirestore
import Foundation

final class Shop: ObservableObject {
    @Published var shop = [ShopStruct]()

    @Published var nameShop = ""
    @Published var email = ""
    @Published var country = ""
    var phone = ""
    @Published var itn = ""
    @Published var contactName = ""
    @Published var term = false
    @Published var isValid = false

    var cancellable: Set<AnyCancellable> = []

    private var isNameShopPublisher: AnyPublisher<Bool, Never> {
        $nameShop
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
        $itn
            .map {
                $0.count > 4
            }
            .eraseToAnyPublisher()
    }

    var isValide: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isNameShopPublisher, isEmailValidPublisher, isITNValidPublisher, $term)
            .map { $0.0 && $0.1 && $0.2 && $0.3 }
            .eraseToAnyPublisher()
    }

    func addData(shopName: String,
                 email: String,
                 country: String,
                 phone: String,
                 itn: String,
                 contactName: String)
    {
        let db = Firestore.firestore()
        db.collection("Shop").addDocument(data: ["shopName": shopName,
                                                 "email": email,
                                                 "country": country,
                                                 "phone": phone,
                                                 "itn": itn,
                                                 "contactName": contactName])
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
                                       shopName: d["shopName"] as? String ?? "dfsd",
                                       email: d["email"] as? String ?? "",
                                       country: d["country"] as? String ?? "",
                                       phone: d["phone"] as? String ?? "",
                                       itn: d["itn"] as? String ?? "",
                                       contactName: d["contactName"] as? String ?? "")
                        }
                    }
                }

            } else {}
        }
    }
}
