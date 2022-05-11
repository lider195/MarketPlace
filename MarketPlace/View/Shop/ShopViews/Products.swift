import SwiftUI

struct MyProducts: View {
    @ObservedObject var myProduct = ProductViewModel()
    @ObservedObject var allProduct = ProductViewModel()

    var body: some View {

        NavigationView {

            ScrollView(.horizontal, showsIndicators: false) {

                HStack {
                    ScrollView {
                        VStack {
                            Text("AllProducts ------>")
                                .font(Font(uiFont: .manrope(25, .regular)))
                            LazyVGrid(columns: allProduct.columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                                ForEach(allProduct.product) { products in
                                    NavigationLink {
                                        InformationProduct(product: products)
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

                    ScrollView {
                        VStack {
                            Text("<------ MyProducts")
                                .font(Font(uiFont: .manrope(25, .regular)))
                            ScrollView {
                                ForEach(myProduct.product) { products in

                                    CellMyProduct(product: products, viewModel: myProduct)
                                        .padding(.vertical, 20)
                                        .foregroundColor(Color.black)
                                        .contextMenu {
                                            Button {
                                                myProduct.deleteData(productToDelete: products)
                                            } label: {
                                                HStack {
                                                    Image(systemName: "delete.left")
                                                    Text("Deleted")
                                                }
                                            }
                                        }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
//
                }
                .ignoresSafeArea(edges: .all)
            }
            .background(Color.theme.background)
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
