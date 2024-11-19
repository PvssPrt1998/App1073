import SwiftUI

@main
struct App1073App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Source())
        }
    }
}
