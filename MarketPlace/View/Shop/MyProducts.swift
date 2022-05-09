import SwiftUI

struct MyProducts: View {
    @ObservedObject var myProduct = ProductViewModel()
    @ObservedObject var allProduct = ProductViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {

        NavigationView {

            ScrollView(.horizontal, showsIndicators: false) {

                HStack {
                    ScrollView {
                        VStack {
                            Text("AllProducts")
                                .font(Font(uiFont: .manrope(25, .regular)))
                            LazyVGrid(columns: columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                                ForEach(allProduct.product) { products in
                                    NavigationLink {
                                        //
                                    } label: {
                                        CellAllProduct(product: products)
                                            .padding(.vertical, 20)
                                            .foregroundColor(Color.black)
                                    }
                                }
                            })
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    List {
                        Text("MyProducts")
                        ForEach(myProduct.product) { products in

                            CellMyProduct(product: products, viewModel: myProduct)

//                    Button(action: {
//
//                        // Delete todo
//                        myProduct.deleteData(productToDelete: products)
//                    }, label: {
//                        Image(systemName: "minus.circle")
//                    })
//                    .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
            .ignoresSafeArea(edges: .all)
        }
        .ignoresSafeArea(edges: .top)
    }

    init() {
        myProduct.getData()
        allProduct.getAllProductionsData()
    }
}

struct MyProducts_Previews: PreviewProvider {
    static var previews: some View {
        MyProducts()
    }
}
