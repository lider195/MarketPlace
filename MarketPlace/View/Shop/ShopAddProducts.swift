import FirebaseFirestore
import FirebaseStorage
import SwiftUI
import UIKit

struct ShopAddProducts: View {
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @ObservedObject var product = ProductViewModel()
    @State var number = UserDefaults.standard.string(forKey: "numberPhone")
    var body: some View {
        NavigationView {

            ScrollView {
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

                        TextFieldsView(shop: $product.thing, text: "The product's name", placeholder: "PS4", checkText: product.thing)
                            .scaleEffect(1.2)
                        HStack(spacing: 50) {
                            VStack {
                                Text("Category")
                                    .font(Font(uiFont: .manrope(18, .semiBold)))
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
                                Text("Gender")
                                    .font(Font(uiFont: .manrope(18, .semiBold)))
                                    .offset(y: 20)
                                Picker("Gender", selection: $product.gender) {
                                    ForEach(product.genders, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .scaleEffect(1.2)
                                .frame(width: 80, height: 75)
                                .pickerStyle(.menu)
                            }

                            VStack {
                                Text("Country")
                                    .font(Font(uiFont: .manrope(18, .semiBold)))
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
                                .font(Font(uiFont: .manrope(18, .semiBold)))
                                .opacity(0.5)
                            TextEditor(text: $product.addDescription)
                                .font(Font(uiFont: .manrope(18, .semiBold)))
                                .frame(minHeight: 80, maxHeight: 120)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 4)
                                )
                        }
                        
                        .padding(.horizontal, 30)
                        TextFieldsView(shop: $product.numberPhone, text: "Phone number", placeholder: "+375298308218", checkText: number ?? product.numberPhone)
                            .font(Font(uiFont: .manrope(18, .semiBold)))
                            .scaleEffect(1.2)
                        ZStack {
                            TextFieldsView(shop: $product.setCost, text: "SetCost", placeholder: "123000", checkText: product.setCost)
                                .font(Font(uiFont: .manrope(18, .semiBold)))
                                .keyboardType(.numberPad)
                            Picker("", selection: $product.currency) {
                                ForEach(product.curren, id: \.self) {
                                    Text($0)
                                }
                            }.scaleEffect(1.5)
                                .pickerStyle(.menu)
                                .offset(x: -145)
                        }.scaleEffect(1.2)

                        Button {
                            product.saveProduct()
                            product.saveAllProduct()
                            //                        product.thing = ""
                            //                        product.category = ""
                            //                        product.countryOfOrigin = ""
                            //                        product.floor = ""
                            //                        product.addDescription = ""
                            //                        product.setCost = ""
                            //                        product.currency = ""
                        } label: {

                            Text("Save product")
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
                .offset(y: 0)

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
                
        }.ignoresSafeArea()
            .onAppear{
                product.numberPhone = number ?? ""
            }
    }
}

struct ShopAddProducts_Previews: PreviewProvider {
    static var previews: some View {
        ShopAddProducts()
    }
}
