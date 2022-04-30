import SwiftUI

struct CellMyProduct: View {
    var product: Product

    var body: some View {

        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Image(uiImage: product.image ?? UIImage(systemName: "plus")!)
                        .resizable()
                        .frame(width: 180, height: 180)
                        .cornerRadius(30)
                }
                VStack(alignment: .trailing) {
                    HStack {
                        Text(product.thing)

                        Text(product.category)
                    }
                    HStack {
                        Text(product.countryOfOrigin)
                    }
                    HStack {

                        Text(product.addDescription)
                        Text("\(product.setCost)\(product.setCost)")
                    }
                }
                .frame(width: 170, height: 180)
            }
        }
        .frame(width: 350, height: 200)
    }
}

struct CellMyProduct_Previews: PreviewProvider {
    static var previews: some View {
        CellMyProduct(product: Product(id: "",
                                       thing: "",
                                       category: "",
                                       countryOfOrigin: "",
                                       floor: "",
                                       addDescription: "",
                                       setCost: "",
                                       currency: ""))
            .previewLayout(.fixed(width: 350, height: 200))
    }
}
