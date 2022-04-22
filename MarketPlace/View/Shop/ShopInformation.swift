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
                    Text("Registration form for sellers")
                        .font(.largeTitle)
                        .padding(.vertical, 20)
                    ZStack {
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Country*")
                                    .offset(x: 5, y: 13)
                                TextField("Ukraine", text: $shop.country)
                                    .textFieldStyle(.roundedBorder)
                                    .opacity(0.8)
                                Divider()
                            }
                            VStack(alignment: .leading) {
                                Text("Individual taxpayer number*")
                                    .offset(x: 5, y: 13)
                                TextField("123456", text: $shop.itn)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .opacity(0.8)
                                Divider()
                            }
                            VStack(alignment: .leading) {
                                Text("Shop Name*")
                                    .offset(x: 5, y: 13)
                                TextField("Not War", text: $shop.nameShop)
                                    .textFieldStyle(.roundedBorder)
                                    .opacity(0.8)
                                Divider()
                            }
                            VStack(alignment: .leading) {
                                Text("Contact Name")
                                    .offset(x: 5, y: 13)
                                TextField("Vladimir", text: $shop.contactName)
                                    .textFieldStyle(.roundedBorder)
                                    .opacity(0.8)
                                    .keyboardType(.namePhonePad)
                                Divider()
                            }
                            VStack(alignment: .leading) {
                                Text("Number Phone")
                                    .offset(x: 5, y: 13)
                                TextField("", text: $shop.phone)
                                    .textFieldStyle(.roundedBorder)
                                    .opacity(0.8)
                                    .keyboardType(.phonePad)
                                Divider()
                            }
                            VStack(alignment: .leading) {
                                Text("Email adres*")
                                    .offset(x: 5, y: 13)
                                TextField("support@example.com", text: $shop.email)
                                    .textFieldStyle(.roundedBorder)
                                    .opacity(0.8)
                                    .keyboardType(.emailAddress)
                                Divider()
                            }
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
                    }.onAppear {

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
