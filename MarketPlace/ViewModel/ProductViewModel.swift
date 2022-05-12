import Combine
import Firebase
import FirebaseFirestore
import Foundation
import SwiftUI
import UIKit
final class ProductViewModel: ObservableObject {
    @Published var product = [Product]()
//    var pro = Product(thing: "dasffa", category: "", countryOfOrigin: "", gender: "", addDescription: "", setCost: "", currency: "", numberPhone: "")

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
    let genders = ["Male", "Female", "Children"]
    let curren = ["$", "₴", "€", "£", "¥"]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var rotation = 0.0

    @Published var thing = ""
    @Published var category = ""
    @Published var countryOfOrigin = ""
    @Published var gender = ""
    @Published var addDescription = ""
    @Published var setCost = ""
    @Published var currency = ""
    @Published var numberPhone = ""
    @Published var photo = false
    @Published var isValid = false
    @Published var tog = true

    var ima = ""
    @Published var showImagePicker1 = false
    @Published var productImage1: UIImage?
    @Published var productImage2 = UIImage()

    @Published var imagess = [UIImage]()

    var shops = UserDefaults.standard.string(forKey: "1")

    func saveProduct() {
        guard productImage1 != nil else {
            return
        }
        let storage = Storage.storage().reference()

        guard let imageData = productImage1?.jpegData(compressionQuality: 0.8) else {
            return
        }

        guard imageData != nil else {
            return
        }
        let path = "images/\(UUID().uuidString).jpg"

        let fileRef = storage.child(path)

        let uploadTask = fileRef.putData(imageData,
                                         metadata: nil)
        { metadata, error in
            if error == nil, metadata != nil {
                let db = Firestore.firestore()
                db.collection(self.shops ?? "ProductInformation").document().setData(["thing": self.thing,
                                                                                      "category": self.category,
                                                                                      "countryOfOrigin": self.countryOfOrigin,
                                                                                      "gender": self.gender,
                                                                                      "addDescription": self.addDescription,
                                                                                      "setCost": self.setCost,
                                                                                      "currency": self.currency,
                                                                                      "numberPhone": self.numberPhone,
                                                                                      "image": path])
                { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.imagess.append(self.productImage1!)
                        }
                    }
                }
            }
        }
    }

//
    func getData() {
        let db = Firestore.firestore()
    //        self.shops ?? "ProductInformation"
        db.collection(shops ?? "ProductInformation").getDocuments { snapshots, error in

            if error == nil, snapshots != nil {
                var paths = [String]()

                for doc in snapshots!.documents {

                    paths.append(doc["image"] as? String ?? "asd")
                }

                if let snapshots = snapshots {
                    for path in paths {
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child(path)
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil, data != nil {

                                if let image = UIImage(data: data!) {

                                    DispatchQueue.main.async {
                                        self.product = snapshots.documents.map { d in

                                            Product(id: d.documentID,
                                                    thing: d["thing"] as? String ?? "thing",
                                                    category: d["category"] as? String ?? "category",
                                                    countryOfOrigin: d["countryOfOrigin"] as? String ?? "countryOfOrigin",
                                                    gender: d["gender"] as? String ?? "floor",
                                                    addDescription: d["addDescription"] as? String ?? "addDescription",
                                                    setCost: d["setCost"] as? String ?? "setCost",
                                                    currency: d["currency"] as? String ?? "currency",
                                                    numberPhone: d["numberPhone"] as? String ?? "+375291234567",
                                                    image1: image)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            } else {}
        }
    }
    
//    func getData() {
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            let db = Firestore.firestore()
//            var products = Product(thing: "", category: "", countryOfOrigin: "", gender: "", addDescription: "", setCost: "", currency: "", numberPhone: "")
//
//            db.collection(self.shops ?? "ProductInformation").getDocuments { snapshot, error in
//                if error == nil {
//                    if let snapshot = snapshot {
//                        self.product = snapshot.documents.compactMap { data in
//
//                            products = Product(id: data.documentID,
//                                               thing: data["thing"] as? String ?? "thing",
//                                               category: data["category"] as? String ?? "category",
//                                               countryOfOrigin: data["countryOfOrigin"] as? String ?? "countryOfOrigin",
//                                               gender: data["gender"] as? String ?? "floor",
//                                               addDescription: data["addDescription"] as? String ?? "addDescription",
//                                               setCost: data["setCost"] as? String ?? "setCost",
//                                               currency: data["currency"] as? String ?? "currency",
//                                               numberPhone: data["numberPhone"] as? String ?? "+375291234567",
//                                               image1: self.productImage2)
//
//                            print(">>>>>>>>>>>>>>>\(String(describing: self.productImage2))")
//
//                            DispatchQueue.main.async {
//
//                                self.ima = data["image"] as? String ?? "fsa"
//                                let storageRef = Storage.storage().reference()
//                                let fileRef = storageRef.child(self.ima)
//                                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, _ in
//                                    if error == nil, data != nil {
//                                        if let image = UIImage(data: data!) {
//                                            self.productImage2 = image
//                                        }
//                                    }
//                                    print("_____________\(String(describing: self.productImage2))")
//                                }
//                            }
//                        }
//                        print("exit to Function")
//                        return products
//                    }
//
//                } else {}
//            }
//        }
//    }

//    func getData() {
//        let db = Firestore.firestore()
    ////        self.shops ?? "ProductInformation"
//        db.collection(shops ?? "ProductInformation").getDocuments { snapshots, error in
//
//            if error == nil, snapshots != nil {
//                var paths = [String]()
//
//                for doc in snapshots!.documents {
//
//                    paths.append(doc["image"] as? String ?? "asd")
//                }
//
//                if let snapshots = snapshots {
//                    for path in paths {
//                        let storageRef = Storage.storage().reference()
//                        let fileRef = storageRef.child(path)
//                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                            if error == nil, data != nil {
//
//                                if let image = UIImage(data: data!) {
//
//                                    DispatchQueue.main.async {
//                                        self.product = snapshots.documents.map { d in
//
//                                            Product(id: d.documentID,
//                                                    thing: d["thing"] as? String ?? "thing",
//                                                    category: d["category"] as? String ?? "category",
//                                                    countryOfOrigin: d["countryOfOrigin"] as? String ?? "countryOfOrigin",
//                                                    gender: d["gender"] as? String ?? "floor",
//                                                    addDescription: d["addDescription"] as? String ?? "addDescription",
//                                                    setCost: d["setCost"] as? String ?? "setCost",
//                                                    currency: d["currency"] as? String ?? "currency",
//                                                    numberPhone: d["numberPhone"] as? String ?? "+375291234567",
//                                                    image1: image)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                   }
//                }
//
//            } else {}
//        }
//    }

    func deleteData(productToDelete: Product) {

        let db = Firestore.firestore()

        db.collection(shops ?? "ProductInformation").document(productToDelete.id).delete { error in

            if error == nil {

                DispatchQueue.main.async {

                    self.product.removeAll { product in

                        product.id == productToDelete.id
                    }
                }
            }
        }
    }

    func saveAllProduct() {
        guard productImage1 != nil else {
            return
        }
        let storage = Storage.storage().reference()

        let imageData = productImage1!.jpegData(compressionQuality: 0.8)

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
                db.collection("ProductInformations").document().setData(["thing": self.thing,
                                                                         "category": self.category,
                                                                         "countryOfOrigin": self.countryOfOrigin,
                                                                         "floor": self.gender,
                                                                         "addDescription": self.addDescription,
                                                                         "setCost": self.setCost,
                                                                         "currency": self.currency,
                                                                         "numberPhone": self.numberPhone,
                                                                         "image": path])
                { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.imagess.append(self.productImage1!)
                        }
                    }
                }
            }
        }
    }

    func getAllProductionsData() {
        let db = Firestore.firestore()
//        self.shops ?? "ProductInformation"
        db.collection("ProductInformations").getDocuments { snapshots, error in

            if error == nil, snapshots != nil {
                var paths = [String]()

                for doc in snapshots!.documents {

                    paths.append(doc["image"] as? String ?? "asd")
                }

                if let snapshots = snapshots {
                    for path in paths {
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child(path)
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil, data != nil {

                                if let image = UIImage(data: data!) {

                                    DispatchQueue.main.async {
                                        self.product = snapshots.documents.map { data in

                                            Product(id: data.documentID,
                                                    thing: data["thing"] as? String ?? "thing",
                                                    category: data["category"] as? String ?? "category",
                                                    countryOfOrigin: data["countryOfOrigin"] as? String ?? "countryOfOrigin",
                                                    gender: data["floor"] as? String ?? "floor",
                                                    addDescription: data["addDescription"] as? String ?? "addDescription",
                                                    setCost: data["setCost"] as? String ?? "setCost",
                                                    currency: data["currency"] as? String ?? "currency",
                                                    numberPhone: data["numberPhone"] as? String ?? "+375291234567",
                                                    image1: image)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            } else {}
        }
    }

    func saveFavoriteProduct() {
        guard productImage1 != nil else {
            return
        }
        let storage = Storage.storage().reference()

        guard let imageData = productImage1?.jpegData(compressionQuality: 0.8) else {
            return
        }

        guard imageData != nil else {
            return
        }
        let path = "images/\(UUID().uuidString).jpg"

        let fileRef = storage.child(path)

        let uploadTask = fileRef.putData(imageData,
                                         metadata: nil)
        { metadata, error in
            if error == nil, metadata != nil {
                let db = Firestore.firestore()
                db.collection("Favorite").document().setData(["thing": self.thing,
                                                              "category": self.category,
                                                              "countryOfOrigin": self.countryOfOrigin,
                                                              "gender": self.gender,
                                                              "addDescription": self.addDescription,
                                                              "setCost": self.setCost,
                                                              "currency": self.currency,
                                                              "numberPhone": self.numberPhone,
                                                              "image": path])
                { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.imagess.append(self.productImage1!)
                        }
                    }
                }
            }
        }
    }

    func getFavoriteData() {
        let db = Firestore.firestore()
//        self.shops ?? "ProductInformation"
        db.collection("Favorite").getDocuments { snapshots, error in

            if error == nil, snapshots != nil {
                var paths = [String]()

                for doc in snapshots!.documents {

                    paths.append(doc["image"] as? String ?? "asd")
                }

                if let snapshots = snapshots {
                    for path in paths {
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child(path)
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil, data != nil {

                                if let image = UIImage(data: data!) {

                                    DispatchQueue.main.async {
                                        self.product = snapshots.documents.map { d in

                                            Product(id: d.documentID,
                                                    thing: d["thing"] as? String ?? "thing",
                                                    category: d["category"] as? String ?? "category",
                                                    countryOfOrigin: d["countryOfOrigin"] as? String ?? "countryOfOrigin",
                                                    gender: d["gender"] as? String ?? "floor",
                                                    addDescription: d["addDescription"] as? String ?? "addDescription",
                                                    setCost: d["setCost"] as? String ?? "setCost",
                                                    currency: d["currency"] as? String ?? "currency",
                                                    numberPhone: d["numberPhone"] as? String ?? "+375291234567",
                                                    image1: image)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            } else {}
        }
    }
}

// func saveFavoriteProduct() {
//        guard productImage1 != nil else {
//            return
//        }
//    let storage = Storage.storage().reference()
//
//     let imageData = productImage1!.jpegData(compressionQuality: 0.8)
//
//
//    guard imageData != nil else {
//        return
//    }
//    let path = "images/\(UUID().uuidString).jpg"
//
//    let fileRef = storage.child(path)
//
//    let uploadTask = fileRef.putData(imageData!,
//                                     metadata: nil)
//    { metadata, error in
//        if error == nil, metadata != nil {
//            let db = Firestore.firestore()
//            db.collection(self.name ?? "ProductInformation").document().setData(["thing": self.thing,
//                                                                                  "category": self.category,
//                                                                                  "countryOfOrigin": self.countryOfOrigin,
//                                                                                  "gender": self.gender,
//                                                                                  "addDescription": self.addDescription,
//                                                                                  "setCost": self.setCost,
//                                                                                  "currency": self.currency,
//                                                                                  "numberPhone": self.numberPhone,
//                                                                                  "image": path])
//            { error in
//                if error == nil {
//                    DispatchQueue.main.async {
//                        self.imagess.append(self.productImage1!)
//                    }
//                }
//            }
//        }
//    }
// }
//
//
//    func getFavoriteData() {
//        let db = Firestore.firestore()
////        self.shops ?? "ProductInformation"
//        db.collection(self.name ?? "ProductInformation").getDocuments { snapshots, error in
//
//            if error == nil, snapshots != nil {
//                var paths = [String]()
//
//                for doc in snapshots!.documents {
//
//                    paths.append(doc["image"] as? String ?? "asd")
//                }
//
//                if let snapshots = snapshots {
//                    for path in paths {
//                        let storageRef = Storage.storage().reference()
//                        let fileRef = storageRef.child(path)
//                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                            if error == nil, data != nil {
//
//                                if let image = UIImage(data: data!) {
//
//                                    DispatchQueue.main.async {
//                                        self.product = snapshots.documents.map { d in
//
//                                            Product(id: d.documentID,
//                                                    thing: d["thing"] as? String ?? "thing",
//                                                    category: d["category"] as? String ?? "category",
//                                                    countryOfOrigin: d["countryOfOrigin"] as? String ?? "countryOfOrigin",
//                                                    gender: d["gender"] as? String ?? "floor",
//                                                    addDescription: d["addDescription"] as? String ?? "addDescription",
//                                                    setCost: d["setCost"] as? String ?? "setCost",
//                                                    currency: d["currency"] as? String ?? "currency",
//                                                    numberPhone: d["numberPhone"] as? String ?? "+375291234567",
//                                                    image1: image)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//
//            } else {}
//        }
//    }
//    func deleteFavoriteData(productToDelete: Product) {
//
//        let db = Firestore.firestore()
//
//        db.collection(self.name ?? "ProductInformation").document(productToDelete.id).delete { error in
//
//            if error == nil {
//
//                DispatchQueue.main.async {
//
//                    self.product.removeAll { product in
//
//                        product.id == productToDelete.id
//                    }
//                }
//            }
//        }
//    }
//
// }

//    func retrieveImage() {
//        let db = Firestore.firestore()
//        db.collection("ProductInformation").getDocuments { snapshots, error in
//            if error == nil, snapshots != nil {
//                var paths = [String]()
//
//                for doc in snapshots!.documents {
//
//                    paths.append(doc["image"] as! String)
//                }

//                for path in paths {
//                    let storageRef = Storage.storage().reference()
//                    let fileRef = storageRef.child(path)
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                        if error == nil, data != nil {
//
//                            if let image = UIImage(data: data!) {
//
//                                DispatchQueue.main.async {
//                                    self.imagess.append(image)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
