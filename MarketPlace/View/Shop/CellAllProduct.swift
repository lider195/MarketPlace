import SwiftUI

struct CellAllProduct: View {
    var product: Product
    var body: some View {

        ZStack {

            VStack(alignment: .leading) {
                VStack {
                    Image(uiImage: product.image1 ?? UIImage(systemName: "plus")!)
                        .resizable()
                        .frame(width: 175, height: 175)
                        .cornerRadius(30)
                }
                HStack {
                    VStack(alignment: .leading,spacing: 20) {

                        Text(product.thing)
                            .font(Font(uiFont: .manrope(20, .semiBold)))
                        Text(product.category)
                            .font(Font(uiFont: .manrope(18, .medium)))
                        HStack{
                            Text(product.currency)
                                .font(Font(uiFont: .manrope(20, .bold)))
                            Text(product.setCost)
                                .font(Font(uiFont: .manrope(18, .light)))
                        }
                    }
                    .padding(.horizontal,20)
                    Spacer()
                }
                .frame(width: 170, height: 125)
            }
            .background(Color.gray)
            .cornerRadius(30)
            .shadow(color: .black, radius: 3, x: 1, y: 5)
        }
        .frame(width: 250, height: 300)
    }
}

struct CellAllProduct_Previews: PreviewProvider {
    static var previews: some View {
        CellMyProduct(product: Product(id: "",
                                       thing: "BMW",
                                       category: "Auto",
                                       countryOfOrigin: "Germany",
                                       gender: "Male",
                                       addDescription: "Best car of germany",
                                       setCost: "250000",
                                       currency: "$",
                                       numberPhone: "+375291234567"), viewModel: ProductViewModel())
            .previewLayout(.fixed(width: 350, height: 200))
    }
}
