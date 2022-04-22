import FirebaseFirestore
import FirebaseStorage
import SwiftUI
import UIKit

struct ShopAddProducts: View {
//    let categories = ["Accessories", "Electronics", "Appliances", "The Beauty", "Toys", "Gold Exchange", "Books", "Garden", "Stationery", "Building Products"]
//    let countries = ["Belarus",
//                     "Kazakhstan",
//                     "Uruguay",
//                     "United Kingdom",
//                     "Germany",
//                     "Venezuela",
//                     "Mexico",
//                     "Spain",
//                     "Greece",
//                     "UAE"]
//    let floors = ["Male", "Female", "Children"]
//    let curren = ["$", "₴", "€", "£", "¥"]

//    @State var thing = ""
//    @State var category = ""
//    @State var countryOfOrigin = ""
//    @State var floor = ""
//    @State var addDescription = ""
//    @State var setCost = ""
//    @State var currency = ""
//    @State var camera = false
//    @State var showImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    // @State var image: UIImage?
    @ObservedObject var product = ProductViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section("Information") {
                    TextField("Thing", text: $product.thing)
                    Picker("Category", selection: $product.category) {
                        ForEach(product.categories, id: \.self) {
                            Text($0)
                        }
                    }

                    Picker("Country Of Origin", selection: $product.countryOfOrigin) {
                        ForEach(product.countries, id: \.self) {
                            Text($0)
                        }
                    }

                    Picker("Floor", selection: $product.floor) {
                        ForEach(product.floors, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    VStack {
                        Text("Add description")
                            .opacity(0.5)
                        TextEditor(text: $product.addDescription)
                            .frame(minHeight: 30, maxHeight: 150)
                    }
                    HStack {
                        TextField("Set Cost", text: $product.setCost)
                            .keyboardType(.numberPad)
                        Picker("", selection: $product.currency) {
                            ForEach(product.curren, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.menu)
                    }
                }
                Section("Add Photo") {
                    Button("Choose Picture") {
                        product.camera = true
                    }
                    .actionSheet(isPresented: $product.camera) {
                        ActionSheet(title: Text("Selected Image"),
                                    message: Text("Choose"),
                                    buttons: [
                                        .default(Text("Photo Library")) {
                                            product.showImagePicker = true
                                            sourceType = .photoLibrary

                                        },
                                        .default(Text("Camera")) {
                                            product.showImagePicker = true
                                            sourceType = .camera
                                        },
                                        .cancel()
                                    ])
                    }
                    HStack {
                        Spacer()
                        Image(uiImage: product.productImage ?? UIImage(systemName: "camera.circle")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Spacer()
                    }
                }
                Section {
                    Button {
                        product.uploadImage()
//                        product.thing = ""
//                        product.category = ""
//                        product.countryOfOrigin = ""
//                        product.floor = ""
//                        product.addDescription = ""
//                        product.setCost = ""
//                        product.currency = ""
                    } label: {
                        Text("Save Information")
                    }
                }
            }
            .fullScreenCover(isPresented: $product.showImagePicker) {
                ImagePicker(image: $product.productImage, isShow: $product.showImagePicker, sourceType: sourceType)
            }
        }.ignoresSafeArea()
    }
}

struct ShopAddProducts_Previews: PreviewProvider {
    static var previews: some View {
        ShopAddProducts()
    }
}
