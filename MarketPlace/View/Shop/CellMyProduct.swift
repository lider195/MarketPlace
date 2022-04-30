import SwiftUI

struct CellMyProduct: View {
    var product: Product

    var body: some View {

        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Image(uiImage: product.image ?? UIImage(systemName: "plus")!)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(30)
                }
                VStack(alignment: .leading) {
                    Spacer()
                    Text(product.thing)
                    Spacer()
                    Text(product.category)

                    Spacer()
                    Text(product.countryOfOrigin)
                    Spacer()
                    Text("\(product.setCost)\(product.currency)")
                    Spacer()
                }
                .frame(width: 150, height: 200)
            }
        }
        .frame(width: 350, height: 200)
    }
}

struct CellMyProduct_Previews: PreviewProvider {
    static var previews: some View {
        CellMyProduct(product: Product(id: "",
                                       thing: "BMW",
                                       category: "Auto",
                                       countryOfOrigin: "Germany",
                                       floor: "Male",
                                       addDescription: "Best car of germany",
                                       setCost: "250000",
                                       currency: "$"))
            .previewLayout(.fixed(width: 350, height: 200))
    }
}
