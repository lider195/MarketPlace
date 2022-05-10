import SwiftUI

struct CellAllProduct: View {
    var product: Product
    @StateObject var favProduct = ProductViewModel()
    @State var rotation = 0.0
    var body: some View {

        ZStack {

            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: product.image1 ?? UIImage(systemName: "plus")!)
                        .resizable()
                        .frame(width: 175, height: 175)
                        .cornerRadius(30)
                    Button {
                        favProduct.tog.toggle()
                        rotation += 360
                    } label: {
                        Image(systemName: favProduct.tog ? "heart" : "heart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(favProduct.tog ? .gray : .red)
                            .animation(.easeInOut(duration: 1.5))
                            .rotationEffect(.degrees(rotation)).animation(.spring(response: 1, dampingFraction: 2, blendDuration: 1))
                    }
                    .padding()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(product.thing)
                            .font(Font(uiFont: .manrope(20, .semiBold)))
                        Text(product.category)
                            .font(Font(uiFont: .manrope(18, .medium)))
                        HStack {
                            Text(product.currency)
                                .font(Font(uiFont: .manrope(20, .bold)))
                            Text(product.setCost)
                                .font(Font(uiFont: .manrope(18, .light)))
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
                .frame(width: 170, height: 125)
            }
            .background(Color.theme.cellColor)
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

//
//favProduct.product.append(Product(
//    thing: product.thing,
//    category: product.category,
//    countryOfOrigin: product.countryOfOrigin,
//    gender: product.gender,
//    addDescription: product.addDescription,
//    setCost: product.setCost,
//    currency: product.currency,
//    numberPhone: product.numberPhone,
//    image1: product.image1
//                                                 ))
