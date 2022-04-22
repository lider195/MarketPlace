import SwiftUI

struct MyProducts: View {
    @ObservedObject var myProduct = ProductViewModel()
    var body: some View {

        List(myProduct.product) { products in
            VStack {
                Text(products.thing)
                Text(products.category)
                Text(products.countryOfOrigin)
                Text(products.floor)
                Text(products.addDescription)
                Text(products.setCost)
                Text(products.currency)
                Image(uiImage: products.image ?? UIImage(systemName: "plus")! )
                
                
//                var thing: String
//                var category: String
//                var countryOfOrigin: String
//                var floor: String
//                var addDescription: String
//                var setCost: String
//                var currency: String
//                var image: UIImage?
                
            }
        }.onAppear{
            myProduct.retrieveImage()
        }
    }
    init() {
        myProduct.getData()
    }
}

struct MyProducts_Previews: PreviewProvider {
    static var previews: some View {
        MyProducts()
    }
}
