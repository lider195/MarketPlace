import SwiftUI

enum FontWeight: String {
    case bold = "Manrope-Bold"
    case extraBold = "Manrope-ExtraBold"
    case extraLight = "Manrope-ExtraLight"
    case light = "Manrope-Light"
    case medium = "Manrope-Medium"
    case regular = "Manrope-Regular"
    case semiBold = "Manrope-SemiBold"
}

extension UIFont {
    static func manrope(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        UIFont(name: weight.rawValue, size: size)!
    }
}
extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
