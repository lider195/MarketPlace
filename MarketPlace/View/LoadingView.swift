import SwiftUI

struct LoadingView: View {
        let timer = Timer
            .publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
        
        let downloadTotal: Double = 100
        @State private var progress: Double = 0
        
        var body: some View {
            VStack(spacing: 40) {
                Text("Downloading: \(Int(progress))%")
                
                ProgressView(value: progress, total: downloadTotal)
                    .tint(progress < 50 ? .pink : .green)
                    .padding(.horizontal)
                    .onReceive(timer) { _ in
                        if progress < downloadTotal { progress += 1 }
                    }
            }
        }
    }

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}


extension View {
    @ViewBuilder
    func isLoading(_ isLoading: Bool) -> some View {
        ZStack {
            self
            if isLoading {
                LoadingView()
            }
        }
        .animation(.linear(duration: 0.2), value: isLoading)
    }
}
