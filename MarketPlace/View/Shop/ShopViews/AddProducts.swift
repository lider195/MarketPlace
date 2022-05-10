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
                        }
                        .background(Color.theme.backgroundMenu)
                        .cornerRadius(20)
                        .padding(.horizontal, 30)

                        TextFieldsView(shop: $product.thing, text: "The product's name", placeholder: "PS4", checkText: product.thing)
                            .scaleEffect(1.2)
                            .font(Font(uiFont: .manrope(18, .light)))
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
                        .background(Color.theme.menuButton)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))

                        VStack {
                            Text("Description")
                                .font(Font(uiFont: .manrope(18, .semiBold)))
                                .opacity(0.7)
                            TextEditor(text: $product.addDescription)
                                .accentColor(Color.red)
                                .font(Font(uiFont: .manrope(18, .light)))
                                .frame(height: 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 4)
                                )
                        }

                        .padding(.horizontal, 30)
                        TextFieldsView(shop: $product.numberPhone, text: "Phone number", placeholder: "+375298308218", checkText: number ?? product.numberPhone)
                            .font(Font(uiFont: .manrope(18, .light)))
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
                                                                    blue: 72 / 255) : Color.theme.menuButton)
                                .clipShape(Capsule())
                        }
                    }
                }
                .background(Color.theme.background.opacity(0.5))
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $product.showImagePicker1) {
                    ImagePicker(image: $product.productImage1, isShow: $product.showImagePicker1, sourceType: sourceType)
                }
            }
            .background(Color.theme.background)
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .onAppear {
            product.numberPhone = number ?? ""
        }
    }
}

struct ShopAddProducts_Previews: PreviewProvider {
    static var previews: some View {
        ShopAddProducts()
    }
}
