import SwiftUI

struct ShopInformation: View {
    @ObservedObject var shop = Shop()
    var body: some View {
        ZStack {
            Image("fon")
                .resizable()
                .opacity(0.1)
                .ignoresSafeArea()
            VStack {
                ScrollView {
//                    Text("Registration form for sellers")
//                        .font(.largeTitle)
//                        .padding(.vertical, 20)
                    ZStack {
                        VStack {
                            TextFieldsView(shop: $shop.country, text: "Country*", placeholder: "Ukraine",proverkaText: shop.country)
                                
                            TextFieldsView(shop: $shop.itn, text: "Itn*", placeholder: "123456",proverkaText: shop.itn)
                                .keyboardType(.numberPad)
                               
                            
                            TextFieldsView(shop: $shop.nameShop, text: "Shop Name*", placeholder: "Not War",proverkaText: shop.nameShop)

                            TextFieldsView(shop: $shop.contactName, text: "Contact Name", placeholder: "Vladimir",proverkaText: shop.contactName)
                                .keyboardType(.namePhonePad)
                            TextFieldsView(shop: $shop.phone, text: "Number Phone", placeholder: "+375298308218",proverkaText: shop.phone)
                                .keyboardType(.phonePad)
                            TextFieldsView(shop: $shop.email, text: "Email adres*", placeholder: "support@example.com",proverkaText: shop.email)

                            HStack {
                                Text(" I agree to the processing \n of personal data ")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 14))
                                    .lineLimit(2)
                                Spacer()
                                Button {
                                    shop.term.toggle()
                                } label: {
                                    Image(systemName: shop.term ? "square.fill" : "square")
                                        .foregroundColor(Color.black)
                                }
                            }.padding()

                            HStack(alignment: .center) {
                                Button {
                                    shop.addData(shopName: shop.nameShop,
                                                 email: shop.email,
                                                 country: shop.country,
                                                 phone: shop.phone,
                                                 itn: shop.itn,
                                                 contactName: shop.contactName)
                                } label: {
                                    Text("Save")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical)
                                        .padding(.horizontal, 50)
                                        .background(shop.isValid ? Color(red: 93 / 255,
                                                                         green: 128 / 255,
                                                                         blue: 168 / 255,
                                                                         opacity: 1) : Color.gray)
                                        .clipShape(Capsule())
                                        .shadow(color: Color.white.opacity(0.1),
                                                radius: 5,
                                                x: 0,
                                                y: -5)
                                }
                                .disabled(!shop.isValid)
                            }
                        }
                    }
                    .padding(.top,100)
                    .onAppear {

                        shop.isValide
                            .receive(on: RunLoop.main)
                            .assign(to: \.shop.isValid, on: self)
                            .store(in: &shop.cancellable)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }

//    init() {
//        shop.getData()
//    }
}

struct ShopInformation_Previews: PreviewProvider {
    static var previews: some View {
        ShopInformation()
    }
}
