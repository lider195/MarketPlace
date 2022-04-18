import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

func signInWithEmail(email: String, password: String,
                     completion: @escaping (Bool, String) -> Void)
{

    Auth.auth().signIn(withEmail: email, password: password) { res, err in

        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
    }
}

func signUpWithEmail(email: String, password: String, confirmPassword: String,
                     completion: @escaping (Bool, String) -> Void)
{

    Auth.auth().createUser(withEmail: email, password: password) { res, err in

        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
    }
}

// func addData(shopName: String,
//             email: String,
//             country: String,
//             phone: String,
//             itn: String,
//             contactName: String){
//    let db = Firestore.firestore()
//    db.collection("Shop").addDocument(data: ["shopName": shopName,
//                                             "email": email,
//                                             "country": country,
//                                             "phone": phone,
//                                             "itn": itn,
//                                             "contactName": contactName])
//    { error in
//        if error == nil {
//            getData()
//        } else {}
//    }
// }
//
// func getData() {
//    let db = Firestore.firestore()
//
//    db.collection("Shop").getDocuments { completion, error in
//
//        if error == nil {
//            if let completion = completion {
//
//                DispatchQueue.main.async {
//
//
//                    Shop.init().shop = completion.documents.map { d in
//
//                        ShopStruct(id: d.documentID,
//                                   shopName: d["shopName"] as? String ?? "dfsd",
//                                   email: d["email"] as? String ?? "",
//                                   country: d["country"] as? String ?? "",
//                                   phone: d["phone"] as? String ?? "",
//                                   itn: d["itn"] as? String ?? "",
//                                   contactName: d["contactName"] as? String ?? "")
//                    }
//                }
//            }
//
//        } else {}
//    }
// }
