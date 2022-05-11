import SwiftUI

struct MenuButtonView: View {
    @ObservedObject var menu = Shop()

    var numberIndex: Int
    var imageName = ""
    var nameCategory = ""

    var body: some View {
        Button {
            menu.index = numberIndex
            print("\(menu.index) \(numberIndex)")
            print(menu.show)
            withAnimation {
                menu.show.toggle()
            
            }
        } label: {
            HStack(spacing: 25) {
                Image(systemName: imageName)
                    .foregroundColor(menu.index == numberIndex ? Color.theme.menuButton : .white)

                Text(nameCategory)
                    .font(Font(uiFont: .manrope(18, .light)))
                    .foregroundColor(menu.index == numberIndex ? Color.theme.menuButton : .white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(menu.index == numberIndex ? Color.theme.menuButton.opacity(0.2) : .clear)
            .cornerRadius(10)
        }
    }
}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView(numberIndex: 1)
    }
}
