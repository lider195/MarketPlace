import SwiftUI

struct MyProducts: View {
    @ObservedObject var myProduct = ProductViewModel()

    var body: some View {

        NavigationView {

            List {
                ForEach(myProduct.product) { products in

                    CellMyProduct(product: products)
                    
//                    Button(action: {
//
//                        // Delete todo
//                        myProduct.deleteData(productToDelete: products)
//                    }, label: {
//                        Image(systemName: "minus.circle")
//                    })
//                    .buttonStyle(BorderlessButtonStyle())
//
//                            Text(products.thing)
//                            Text(products.category)
//                            Text(products.countryOfOrigin)
//                            Text(products.floor)
//                            Text(products.addDescription)
//                            Text(products.setCost)
//                            Text(products.currency)
//                            Image(uiImage: (products.image ?? UIImage(systemName: "phone"))!)
//                                .resizable()
//                                .frame(width: 100, height: 100)
                }
            }
            .padding(.top, -70)
        }
        .ignoresSafeArea(edges: .top)
    }

    init() {
        myProduct.getData()
//        myProduct.getAllProductionsData()
    }
}

struct MyProducts_Previews: PreviewProvider {
    static var previews: some View {
        MyProducts()
    }
}
