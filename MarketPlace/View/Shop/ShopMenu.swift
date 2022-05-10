
import SwiftUI

struct ShopMenu: View {
    @State var index = 0
    @State var show = false
    @State var alert = false
    @State var name = UserDefaults.standard.string(forKey: "name")
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Image("fon")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                    Text("Hello,")
                        .font(Font(uiFont: .manrope(26, .light)))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    Text(name ?? "")
                        .font(Font(uiFont: .manrope(30, .semiBold)))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Button {
                        index = 0

                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "magazine")
                                .foregroundColor(index == 0 ? Color.theme.menuButton : .white)

                            Text("Product")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(index == 0 ? Color.theme.menuButton : .white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(index == 0 ? Color.theme.menuButton.opacity(0.2) : .clear)
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
                            Image(systemName: "bag")
                                .foregroundColor(index == 1 ? Color.theme.menuButton : .white)

                            Text("Add Product")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(index == 1 ? Color.theme.menuButton : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(index == 1 ? Color.theme.menuButton.opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
                    Button {
                        index = 2
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "gear")
                                .foregroundColor(index == 2 ? Color.theme.menuButton : .white)

                            Text("Information Profile")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(index == 2 ? Color.theme.menuButton : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(index == 2 ? Color.theme.menuButton.opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
                    Button {
                        index = 3
                        withAnimation {
                            show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "suit.heart.fill")
                                .foregroundColor(index == 3 ? Color.theme.menuButton : .white)

                            Text("Products")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(index == 3 ? Color.theme.menuButton : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(index == 3 ? Color.theme.menuButton.opacity(0.2) : .clear)
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
                                .font(Font(uiFont: .manrope(20, .bold)))
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
                        Image(systemName: self.show ? "chevron.backward" : "text.alignleft")
                            .resizable()
                            .frame(width: self.show ? 18 : 22, height: 18)
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    Text(index == 0 ? "Product" : (index == 1 ? "Add Product" : (index == 2 ? "Profile Information" : "Products")))
                        .foregroundColor(Color.black.opacity(0.6))

                        .font(Font(uiFont: .manrope(23, .medium)))
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
                            ShopInformation(shop: Shop())
                        } else {
                            AllProducts()
                        }
                    }
                }
            }
            .background(Color.theme.background)
            .cornerRadius(show ? 30 : 0)
            .scaleEffect(show ? 0.85 : 1)
            .offset(x: show ? UIScreen.main.bounds.width / 2 : 0, y: show ? 15 : 0)
            .rotationEffect(.init(degrees: show ? -5 : 0))
        }
        .background(Color.theme.backgroundMenu).edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
}

struct ShopMenu_Previews: PreviewProvider {
    static var previews: some View {
        ShopMenu()
    }
}
