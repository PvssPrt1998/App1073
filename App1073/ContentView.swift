import SwiftUI

struct ContentView: View {
    
    @State var screen: Screen = .splash
    
    var body: some View {
        switch screen {
        case .splash:
            Splash(screen: $screen)
        case .main:
            Tab()
        case .register:
            Register(screen: $screen)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Source())
}

enum Screen {
    case splash
    case main
    case register
}
