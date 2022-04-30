import FirebaseFirestore
import FirebaseStorage
import SwiftUI
import UIKit

struct ShopAddProducts: View {
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @ObservedObject var product = ProductViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Button {
                                product.showImagePicker1 = true
                                sourceType = .photoLibrary

                            } label: {
                                Image(uiImage: product.productImage1 ?? UIImage(systemName: "tray.and.arrow.down")!)
                                    .resizable()
                                    .image()
                            }
                            .formImage()
                            Button {
                                product.showImagePicker2 = true
                                sourceType = .photoLibrary
                            } label: {
                                Image(uiImage: product.productImage2 ?? UIImage(systemName: "tray.and.arrow.down")!)
                                    .resizable()
                                    .image()
                            }
                            .formImage()
                            Button {
                                product.showImagePicker3 = true
                                sourceType = .photoLibrary
                            } label: {
                                Image(uiImage: product.productImage3 ?? UIImage(systemName: "tray.and.arrow.down")!)
                                    .resizable()
                                    .image()
                            }
                            .formImage()

                            Button {
                                product.showImagePicker4 = true
                                sourceType = .photoLibrary
                            } label: {
                                Image(uiImage: product.productImage4 ?? UIImage(systemName: "tray.and.arrow.down")!)
                                    .resizable()
                                    .image()
                            }
                            .formImage()
                        }
                        .background(Color.indigo)
                        .cornerRadius(20)
                        .padding(.horizontal, 30)
                    }

                    TextFieldsView(shop: $product.thing, text: "The product's name", placeholder: "Market", proverkaText: product.thing)
                        .scaleEffect(1.2)
                    HStack(spacing: 50) {
                        VStack {
                            Text("Category")
                                .offset(y: 30)
                            Picker("Category", selection: $product.category) {
                                ForEach(product.categories, id: \.self) {
                                    Text($0)
                                }
                            }.scaleEffect(1.2)
                                .frame(width: 100, height: 75)
                        }
                        .padding(.horizontal, 10)
                        VStack {
                            Text("Floor")
                                .offset(y: 20)
                            Picker("Floor", selection: $product.floor) {
                                ForEach(product.floors, id: \.self) {
                                    Text($0)
                                }
                            }
                            .scaleEffect(1.2)
                            .frame(width: 80, height: 75)
                            .pickerStyle(.menu)
                        }

                        VStack {
                            Text("Country")
                                .offset(y: 30)
                            Picker("Country Of Origin", selection: $product.countryOfOrigin) {
                                ForEach(product.countries, id: \.self) {
                                    Text($0)
                                }

                            }.scaleEffect(1.2)
                                .frame(width: 100, height: 75)
                        }
                    }
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))

                    VStack {
                        Text("Description")
                            .opacity(0.5)
                        TextEditor(text: $product.addDescription)
                            .frame(minHeight: 30, maxHeight: 150)
                            .border(.gray)
                    }
                    .padding(.horizontal, 30)
                    ZStack {
                        TextFieldsView(shop: $product.setCost, text: "SetCost", placeholder: "123000", proverkaText: product.setCost)
                            .keyboardType(.numberPad)
                        Picker("", selection: $product.currency) {
                            ForEach(product.curren, id: \.self) {
                                Text($0)
                            }
                        }.scaleEffect(1.6)
                            .pickerStyle(.menu)
                            .offset(x: -150)
                    }.scaleEffect(1.2)

                    Button {
                        product.saveProduct()
                        //                        product.thing = ""
                        //                        product.category = ""
                        //                        product.countryOfOrigin = ""
                        //                        product.floor = ""
                        //                        product.addDescription = ""
                        //                        product.setCost = ""
                        //                        product.currency = ""
                    } label: {
                        
                        Text("Save Information")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(product.isValid ? Color(red: 243 / 255,
                                                               green: 122 / 255,
                                                               blue: 72 / 255) : Color.gray)
                            .clipShape(Capsule())
                            
                    }
                }
            }
            .offset(y: -50)
            
            .fullScreenCover(isPresented: $product.showImagePicker1) {
                ImagePicker(image: $product.productImage1, isShow: $product.showImagePicker1, sourceType: sourceType)
            }
            .fullScreenCover(isPresented: $product.showImagePicker2) {
                ImagePicker(image: $product.productImage2, isShow: $product.showImagePicker2, sourceType: sourceType)
            }
            .fullScreenCover(isPresented: $product.showImagePicker3) {
                ImagePicker(image: $product.productImage3, isShow: $product.showImagePicker3, sourceType: sourceType)
            }
            .fullScreenCover(isPresented: $product.showImagePicker4) {
                ImagePicker(image: $product.productImage4, isShow: $product.showImagePicker4, sourceType: sourceType)
            }

        }.ignoresSafeArea()
    }
}

struct ShopAddProducts_Previews: PreviewProvider {
    static var previews: some View {
        ShopAddProducts()
    }
}
