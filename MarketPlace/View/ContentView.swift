import SwiftUI

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View {
        // ShopInformation()
        VStack {
            if status {
                //                CreatedProfile()
                ShopInformation()
            } else {
                LoginView(signUP: LogIn())
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"),
                                                   object: nil,
                                                   queue: .main)
            { _ in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
