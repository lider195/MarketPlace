import SwiftUI
import Firebase
import FirebaseAuth

@main
struct MarketPlaceApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
