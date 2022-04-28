import SwiftUI

struct TextFieldsView: View {
    var shop: Binding<String>
    var text = ""
    var placeholder = ""
    var proverkaText = ""
    var body: some View {
        VStack(alignment: .leading) {
//            Text(text)
//                .offset(x: 5, y: 13)
//            TextField(placeholder, text: shop)
//                .textFieldStyle(.roundedBorder)
//                .opacity(0.8)
//            Divider()

            ZStack(alignment: .trailing) {
                Text(text)
                    .foregroundColor(proverkaText.isEmpty ? Color.red : Color.green)
                    .opacity(1)
                    .offset(y: proverkaText.isEmpty ? -4 : -25)
                    .animation(.easeInOut(duration: 2))
                Spacer()

                VStack {
                    TextField(placeholder, text: shop)
                        .disableAutocorrection(true)
                    Divider()
                        .background(proverkaText.isEmpty ? Color.red : Color.green)
                        .animation(.linear(duration: 1))
                        .offset(y: -7)
                }
                .frame(width: 280)
                .offset(y: 3)
            }
            .padding()
        }
    }
}

struct TextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldsView(shop: Binding<String>.constant("asd"), text: "", placeholder: "", proverkaText: "")
    }
}
