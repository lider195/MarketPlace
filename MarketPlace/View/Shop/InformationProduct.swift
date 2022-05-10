import SwiftUI

struct InformationProduct: View {
    var product: Product

    var body: some View {
        ZStack {
            Color.theme.background

            VStack(alignment: .leading) {
                VStack {

                    Image(uiImage: (product.image1 ?? UIImage(systemName: "plus"))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 2.5)
                        .cornerRadius(20)
                      
                }
                .padding(.leading,20)
                

                VStack(alignment:.leading ,spacing: 20) {
                    HStack(spacing: 30) {
                        Text(product.thing)
                            .font(Font(uiFont: .manrope(25, .bold)))
                        Text(product.countryOfOrigin)
                            .font(Font(uiFont: .manrope(17, .light)))
                            .foregroundColor(.gray)
                            .offset(y:10)
                    }

                    HStack {
                        Text(product.category)
                            .font(Font(uiFont: .manrope(25, .light)))
                        Text(product.gender)
                            .font(Font(uiFont: .manrope(17, .extraLight)))
                            .foregroundColor(.gray)
                            .offset(y:10)

                    }

                    HStack {
                        Text(product.currency)
                            .font(Font(uiFont: .manrope(22, .bold)))
                            .foregroundColor(.secondary)
                        Text(product.setCost)
                            .font(Font(uiFont: .manrope(22, .semiBold)))
                            
                    }
                    Text(product.addDescription)
                        .frame(width: 350 , height: 100)
                        .font(Font(uiFont: .manrope(15, .light)))
                        .lineLimit(8)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    Button {
                        let formattedString = "tel://" + product.numberPhone
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        HStack {
                            Image(systemName: "phone")
                            Text(product.numberPhone)
                                .font(Font(uiFont: .manrope(20, .semiBold)))

                        }
                        .frame(width: 350 , height: 50)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                    }
//                    .padding(.leading,80)
                                        
                }
                .padding(.horizontal,20)
            }
        }
        .background(Color.theme.background)
        .padding(.top,-100)
    }
}

struct InformationProduct_Previews: PreviewProvider {
    static var previews: some View {
        InformationProduct(product: Product(thing: "BMW",
                                            category: "Car",
                                            countryOfOrigin: "Germany",
                                            gender: "male",
                                            addDescription: "fkladsfadsfdsafadsfdsafadsfadsfadsfdasfadsfadsfdasfdasfadsfasdfasdfasdfdasfmflkkfasd",
                                            setCost: "30200",
                                            currency: "$",
                                            numberPhone: "+375298308218"))
    }
}
