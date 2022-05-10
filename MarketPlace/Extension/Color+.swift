import Foundation
import SwiftUI
import UIKit

extension Color {
    static let theme = ColorTheme()
}

// Example: Color.theme.secondaryText
struct ColorTheme {
    let backgroundMenu = Color("BackgroundMenu")
    let menuButton = Color("MenuButton")
    let background = Color("Background")
    let cellColor = Color("CellColor")
}
