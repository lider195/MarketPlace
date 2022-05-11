import SwiftUI

struct CellMyProduct: View {
    var product: Product
    var viewModel:ProductViewModel
    var body: some View {

        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Image(uiImage: product.image1 ?? UIImage(systemName: "plus")!)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(30)
                }
                .padding()
                VStack(alignment: .leading,spacing: 20) {
                    HStack{
                        Spacer()
                    Button(action: {
                        viewModel.deleteData(productToDelete: product)
                    }, label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(.red)
                    })
                    .scaleEffect(1.4)
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.trailing,20)
                }
                    Text(product.thing)
                        .font(Font(uiFont: .manrope(20, .extraBold)))
                    Text(product.category)
                        .font(Font(uiFont: .manrope(20, .semiBold)))
                        .opacity(0.7)
                        .offset(x: 40, y: -10)

                    Text(product.countryOfOrigin)
                        .font(Font(uiFont: .manrope(20, .semiBold)))

                    Text("\(product.setCost)\(product.currency)")
                }
                .frame(width: 150, height: 200)
            }
        }
        .animation(.spring(response: 1, dampingFraction: 2, blendDuration: 1))
        .background(Color.theme.cellColor)
        .cornerRadius(25)
        
    }
}

struct CellMyProduct_Previews: PreviewProvider {
    static var previews: some View {
        CellMyProduct(product: Product(id: "",
                                       thing: "BMW",
                                       category: "Auto",
                                       countryOfOrigin: "Germany",
                                       gender: "Male",
                                       addDescription: "Best car of germany",
                                       setCost: "250000",
                                       currency: "$", numberPhone: "+375298308218"), viewModel: ProductViewModel())
            .previewLayout(.fixed(width: 350, height: 200))
    }
}
