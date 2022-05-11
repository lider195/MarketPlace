
import SwiftUI

struct ShopMenu: View {
    @ObservedObject var menu = Shop()
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
                    
//                    MenuButtonView( numberIndex: 0, imageName: "magazine", nameCategory: "Product")
                    Button {
                        menu.index = 0

                        withAnimation {
                            menu.show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "magazine")
                                .foregroundColor(menu.index == 0 ? Color.theme.menuButton : .white)

                            Text("Product")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(menu.index == 0 ? Color.theme.menuButton : .white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(menu.index == 0 ? Color.theme.menuButton.opacity(0.2) : .clear)
                        .cornerRadius(10)
                    }
                    .padding(.top, 25)
                    
//                    MenuButtonView( numberIndex: 1, imageName: "bag", nameCategory: "Add Product")
                    Button {
                        menu.index = 1
                        withAnimation {
                            menu.show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "bag")
                                .foregroundColor(menu.index == 1 ? Color.theme.menuButton : .white)

                            Text("Add Product")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(menu.index == 1 ? Color.theme.menuButton : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(menu.index == 1 ? Color.theme.menuButton.opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
//                    MenuButtonView( numberIndex: 2, imageName: "gear", nameCategory: "Information Profile")
                    Button {
                        menu.index = 2
                        withAnimation {
                            menu.show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "gear")
                                .foregroundColor(menu.index == 2 ? Color.theme.menuButton : .white)

                            Text("Information Profile")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(menu.index == 2 ? Color.theme.menuButton : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(menu.index == 2 ? Color.theme.menuButton.opacity(0.2) : .clear)
                            .cornerRadius(10)
                    }
//                    MenuButtonView( numberIndex: 3, imageName: "suit.heart.fill", nameCategory: "Favorite product")

                    Button {
                        menu.index = 3
                        withAnimation {
                            menu.show.toggle()
                        }
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "suit.heart.fill")
                                .foregroundColor(menu.index == 3 ? Color.theme.menuButton : .white)

                            Text("Products")
                                .font(Font(uiFont: .manrope(18, .light)))
                                .foregroundColor(menu.index == 3 ? Color.theme.menuButton : .white)

                        }.padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(menu.index == 3 ? Color.theme.menuButton.opacity(0.2) : .clear)
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
                            menu.show.toggle()
                        }
                    } label: {
                        Image(systemName: menu.show ? "chevron.backward" : "text.alignleft")
                            .resizable()
                            .frame(width: menu.show ? 18 : 22, height: 18)
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    Text(menu.index == 0 ? "Product" : (menu.index == 1 ? "Add Product" : (menu.index == 2 ? "Profile Information" : "Products")))
                        .foregroundColor(Color.black.opacity(0.6))

                        .font(Font(uiFont: .manrope(23, .medium)))
                    Spacer(minLength: 0)
                }
                .padding(.top, 30 )//UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()

                GeometryReader { _ in
                    VStack {
                        if menu.index == 0 {
                            MyProducts()
                        } else if menu.index == 1 {
                            ShopAddProducts()
                        } else if menu.index == 2 {
                            ShopInformation(shop: Shop())
                        } else {
                            AllProducts()
                        }
                    }
                }
            }
            .background(Color.theme.background)
            .cornerRadius(menu.show ? 30 : 0)
            .scaleEffect(menu.show ? 0.85 : 1)
            .offset(x: menu.show ? UIScreen.main.bounds.width / 2 : 0, y: menu.show ? 15 : 0)
            .rotationEffect(.init(degrees: menu.show ? -5 : 0))
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
