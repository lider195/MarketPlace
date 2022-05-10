import SwiftUI

struct AllProducts: View {
    @ObservedObject var favProducts = ProductViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {

        NavigationView {
            ScrollView {
                VStack {
                    Text("Favorite product")
                        .font(Font(uiFont: .manrope(25, .regular)))
                    LazyVGrid(columns: columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                        ForEach(favProducts.product) { products in
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
        }
        
        .ignoresSafeArea(edges: .top)
        .ignoresSafeArea(edges: .all)
    }

}

struct AllProducts_Previews: PreviewProvider {
    static var previews: some View {
        AllProducts()
    }
}

//
// ScrollViewReader { scrollView in
//    ScrollView {
//        Button("Scroll to bottom") {
//            scrollView.scrollTo(99, anchor: .center)
//        }
//
//        ForEach(0..<100) { index in
//            Text(String(index))
//                .id(index)
//        }
//    }
// }
