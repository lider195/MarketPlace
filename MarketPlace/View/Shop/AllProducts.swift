import SwiftUI

struct AllProducts: View {
    @ObservedObject var myProduct = ProductViewModel()

    var body: some View {
       
             ScrollViewReader { scrollView in
                 ScrollView {
                     Button("Scroll to bottom") {
                         scrollView.scrollTo(99, anchor: .center)
                     }

                     ForEach(0..<100) { index in
                         Text(String(index))
                             .id(index)
                     }
                 }
             }
         
    }
}

struct AllProducts_Previews: PreviewProvider {
    static var previews: some View {
        AllProducts()
    }
}
