import SwiftUI

struct Images: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .foregroundColor(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    
}
struct FormImage: ViewModifier {
    
    func body(content: Content) -> some View {
        content
//            .background(Color.yellow)
            .padding(.vertical,20)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal,20)
    }
    
    
}

extension View {
    func image() -> some View {
        modifier(Images())
    }
    func formImage() -> some View {
        modifier(FormImage())
    }
   
}
