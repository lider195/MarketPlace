import Combine
import Firebase
import FirebaseFirestore
import Foundation
import UIKit
final class ProductViewModel: ObservableObject {
    @Published var product = [Product]()

    let categories = ["Accessories", "Electronics", "Appliances", "The Beauty", "Toys", "Gold Exchange", "Books", "Garden", "Stationery", "Building Products"]
    let countries = ["Belarus",
                     "Kazakhstan",
                     "Uruguay",
                     "United Kingdom",
                     "Germany",
                     "Venezuela",
                     "Mexico",
                     "Spain",
                     "Greece",
                     "UAE"]
    let floors = ["Male", "Female", "Children"]
    let curren = ["$", "₴", "€", "£", "¥"]

    @Published var thing = ""
    @Published var category = ""
    @Published var countryOfOrigin = ""
    @Published var floor = ""
    @Published var addDescription = ""
    @Published var setCost = ""
    @Published var currency = ""
    @Published var camera = false
    @Published var showImagePicker = false
    @Published var productImage: UIImage?
    @Published var imagess = [UIImage]()

    func saveProduct() {
        guard productImage != nil else {
            return
        }

        let storage = Storage.storage().reference()

        let imageData = productImage!.jpegData(compressionQuality: 0.8)

        guard imageData != nil else {
            return
        }
        let path = "images/\(UUID().uuidString).jpg"

        let fileRef = storage.child(path)

        let uploadTask = fileRef.putData(imageData!,
                                         metadata: nil)
        { metadata, error in
            if error == nil, metadata != nil {
                let db = Firestore.firestore()
                db.collection("ProductInformation").document().setData(["thing": self.thing,
                                                                        "category": self.category,
                                                                        "countryOfOrigin": self.countryOfOrigin,
                                                                        "floor": self.floor,
                                                                        "addDescription": self.addDescription,
                                                                        "setCost": self.setCost,
                                                                        "currency": self.currency,
                                                                        "image": path])
                { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.imagess.append(self.productImage!)
                        }
                    }
                }
            }
        }
    }

    func retrieveImage() {
        let db = Firestore.firestore()
        db.collection("ProductInformation").getDocuments { snapshots, error in
            if error == nil, snapshots != nil {
                var paths = [String]()
                
                for doc in snapshots!.documents {

                    paths.append(doc["image"] as! String)
                }

                for path in paths {
                    let storageRef = Storage.storage().reference()
                    let fileRef = storageRef.child(path)
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if error == nil, data != nil {

                            if let image = UIImage(data: data!) {

                                DispatchQueue.main.async {
                                    self.imagess.append(image) 
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func getData() {
        let db = Firestore.firestore()

        db.collection("ProductInformation").getDocuments { completion, error in

            if error == nil {
                if let completion = completion {

                    DispatchQueue.main.async {
                        self.product = completion.documents.map { d in

                            Product(id: d.documentID,
                                    thing: d["thing"] as? String ?? "thing",
                                    category: d["category"] as? String ?? "category",
                                    countryOfOrigin: d["countryOfOrigin"] as? String ?? "countryOfOrigin",
                                    floor: d["floor"] as? String ?? "floor",
                                    addDescription: d["addDescription"] as? String ?? "addDescription",
                                    setCost: d["setCost"] as? String ?? "setCost",
                                    currency: d["currency"] as? String ?? "currency",
                                    image: d["image"] as? UIImage ?? UIImage(systemName: "plus")
                            )
                        }
                    }
                }

            } else {}
        }
    }
}
