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
                        ZStack {
                            VStack {
                                TextFieldsView(shop: $shop.name, text: "Name*", placeholder: "Ivan", checkText: shop.name)
                                    .autocapitalization(.none)
                                TextFieldsView(shop: $shop.surName, text: "Sur name", placeholder: "Ivanov", checkText: shop.surName)
                                    .autocapitalization(.none)
                                TextFieldsView(shop: $shop.phoneNumber, text: "Number Phone", placeholder: "+375298308218", checkText: shop.phoneNumber)
                                    .keyboardType(.phonePad)
                                TextFieldsView(shop: $shop.email, text: "Email adress*", placeholder: "support@example.com", checkText: shop.email)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                TextFieldsView(shop: $shop.country, text: "Country*", placeholder: "Ukraine", checkText: shop.country)
                                HStack {
                                    Text(" I agree to the processing \n of personal data ")
                                        .foregroundColor(.gray)
                                        .font(Font(uiFont: .manrope(16, .light)))
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
                                        UserDefaults.standard.set(shop.name, forKey: "name")
                                        UserDefaults.standard.set(shop.phoneNumber, forKey: "numberPhone")

                                        shop.addData(name: shop.name,
                                                     surName: shop.surName,
                                                     phoneNumber: shop.phoneNumber,
                                                     email: shop.email,
                                                     country: shop.country)
                                    } label: {
                                        Text("Save")
                                            .foregroundColor(.white)
                                            .font(Font(uiFont: .manrope(20, .semiBold)))
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
                        .padding(.top, 80)
//                        .padding(.bottom, 50)

                        .padding(.horizontal, 20)
                    }
                }
            }
            .onAppear {
                shop.isFormValid
                    .receive(on: RunLoop.main)
                    .assign(to: \.shop.isValid, on: self)
                    .store(in: &shop.cancellable)
            }
    }
}

struct ShopInformation_Previews: PreviewProvider {
    static var previews: some View {
        ShopInformation()
    }
}
