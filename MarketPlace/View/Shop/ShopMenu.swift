
import SwiftUI

struct ShopMenu: View {
    @State var index = 0
    @State var show = false
    @State var alert = false
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Image("fon")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                    Text("Hello")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    Text("Vadim")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Button {
                        index = 0

                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image("catalogue")
                                .foregroundColor(index == 0 ? Color("Color1") : .white)

                            Text("My Product")
                                .foregroundColor(index == 0 ? Color("Color1") : .white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(index == 0 ? Color("Color1").opacity(0.2) : .clear)
                        .cornerRadius(10)
                    }
                    .padding(.top, 25)
                    Button {
                        index = 1
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image("cart")
                                .foregroundColor(index == 1 ? Color("Color1") : .white)

                            Text("Add Product")
                                .foregroundColor(index == 1 ? Color("Color1") : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(index == 1 ? Color("Color1").opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
                    Button {
                        index = 2
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image("fav")
                                .foregroundColor(index == 2 ? Color("Color1") : .white)

                            Text("Shop Informations")
                                .foregroundColor(index == 2 ? Color("Color1") : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(index == 2 ? Color("Color1").opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
                    Button {
                        index = 3
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image("orders")
                                .foregroundColor(index == 3 ? Color("Color1") : .white)

                            Text("Orders")
                                .foregroundColor(index == 3 ? Color("Color1") : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(index == 3 ? Color("Color1").opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical, 30)
                    Button {
                        alert = true
                    } label: {
                        HStack(spacing: 25) {
                            Image("out")
                                .foregroundColor(Color.white)
                            Text("Exit")
                                .foregroundColor(Color.white)
                        }
                        .alert(isPresented: $alert) {
                            Alert(title: Text("Sign Out"),
                                  message: Text("Are you sure you want to log out of your account?"),
                                  primaryButton: .destructive(Text("Yes")) {
                                          UserDefaults.standard.set(false, forKey: "status")
                                          NotificationCenter.default.post(name: NSNotification.Name("statusChange"),
                                                                          object: nil)
                                  },
                                  secondaryButton: .cancel())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                }
                .padding(.top, 25)
                .padding(.horizontal, 10)
                Spacer(minLength: 0)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.bottom)

            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    Button {
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                            .resizable()
                            .frame(width: self.show ? 18 : 22, height: 18)
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    Text(index == 0 ? "My Product" : (index == 1 ? "Add Product" : (index == 2 ? "Registration form for sellers" : "Orders")))
                        .foregroundColor(Color.black.opacity(0.6))

                        .font(.title)
                    Spacer(minLength: 0)
                }
                .padding(.top, 30 )//UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()

                GeometryReader { _ in
                    VStack {
                        if index == 0 {
                            MyProducts()
                        } else if index == 1 {
                            ShopAddProducts()
                        } else if index == 2 {
                            ShopInformation()
                        } else {
                            orders()
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(show ? 30 : 0)
            .scaleEffect(show ? 0.85 : 1)
            .offset(x: show ? UIScreen.main.bounds.width / 2 : 0, y: show ? 15 : 0)
            .rotationEffect(.init(degrees: show ? -5 : 0))
        }
        .background(Color("Color")).edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
}


struct orders: View {
    var body: some View {
        VStack {
            Text("My Orders")
        }
    }
}


struct ShopMenu_Previews: PreviewProvider {
    static var previews: some View {
        ShopMenu()
    }
}
