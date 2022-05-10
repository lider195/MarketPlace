import SwiftUI

struct TextFieldsView: View {
    var shop: Binding<String>
    var text = ""
    var placeholder = ""
    var checkText = ""
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
            ZStack(alignment: .trailing) {
                Text(text)
                    .font(Font(uiFont: .manrope(16, .light)))
                    .foregroundColor(checkText.isEmpty ? Color.red : Color.green)
                    .offset(y: checkText.isEmpty ? 0 : -14)
                    .rotationEffect(.degrees(checkText.isEmpty ? 0 : 2 ))
                    .animation(.easeInOut(duration:2))
                Spacer()

                
                    TextField(placeholder, text: shop)
                        .disableAutocorrection(true)
                    Divider()
                        .background(checkText.isEmpty ? Color.red : Color.green)
                        .animation(.linear(duration: 1))
                        .offset(y: 13)
                        .opacity(1.5)
                }
                .frame(width: 280)
                .offset(y: 3)
                .padding()
                .background(Color.gray.opacity(0.6))
                .clipShape(CShape2())
                .cornerRadius(20)
            }
            .padding()
            
        }
        
    }
}

struct TextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldsView(shop: Binding<String>.constant("prodd"), text: "Proverka", placeholder: "", checkText: "")
    }
}
