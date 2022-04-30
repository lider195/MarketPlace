
import Foundation
import UIKit

struct Product: Identifiable {
    var id: String

    var thing: String
    var category: String
    var countryOfOrigin: String
    var floor: String
    var addDescription: String
    var setCost: String
    var currency: String
    var image1: UIImage?
    var image2: UIImage?
    var image3: UIImage?
    var image4: UIImage?
    var image5: UIImage?
    var images = [UIImage]()
}
