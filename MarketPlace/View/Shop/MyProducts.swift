import SwiftUI

struct MyProducts: View {
    @ObservedObject var myProduct = ProductViewModel()
    
    
    
    var body: some View {
        ScrollView {
            HStack {
                VStack{
                ForEach(myProduct.product) { products in
                    Text(products.thing)
                    Text(products.category)
                    Text(products.countryOfOrigin)
                    Text(products.floor)
                    Text(products.addDescription)
                    Text(products.setCost)
                    Text(products.currency)
                    
//                    Image(uiImage: products.image ?? UIImage(systemName: "plus")!)
//                        .resizable()
//                        .frame(width: 100, height: 100)
                    
                }
                }
                    VStack{
                    ForEach(myProduct.imagess, id: \.self) { img in
                        Image(uiImage: img)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                    }
                

               
//                List(myProduct,id:\.self) { products in
                ////                    Text(products.thing)
                ////                    Text(products.category)
                ////                    Text(products.countryOfOrigin)
                ////                    Text(products.floor)
                ////                    Text(products.addDescription)
                ////                    Text(products.setCost)
                ////                    Text(products.currency)
//
//
//                }
//        List(myProduct.product) { products in
//            HStack{
//            VStack {
//
//                Image(uiImage: products.image ?? UIImage(systemName: "plus")!)
//            }
//            }
//        }
//                var thing: String
//                var category: String
//                var countryOfOrigin: String
//                var floor: String
//                var addDescription: String
//                var setCost: String
//                var currency: String
//                var image: UIImage?

                //      }
            }
            .onAppear {
                myProduct.retrieveImage()
            }
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
