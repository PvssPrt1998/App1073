import SwiftUI

struct Register: View {
    
    @State var selection = 0
    @Binding var screen: Screen
    
    var body: some View {
        ScrollView([], showsIndicators: false) {
            TabView(selection: $selection) {
                Register1(selection: $selection)
                    .tag(0)
                Register2(selection: $selection, screen: $screen)
                    .tag(1)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onAppear {
            AppDelegate.orientationLock = .portrait
            UIScrollView.appearance().bounces = false
            UIScrollView.appearance().isScrollEnabled = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
            UIScrollView.appearance().isScrollEnabled = true
        }
    }
}

struct Register_Preview: PreviewProvider {
    
    @State static var screen: Screen = .register
    
    static var previews: some View {
        Register(screen: $screen)
    }
    
}
