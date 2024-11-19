import SwiftUI

struct Register1: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Binding var selection: Int
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                upperView
                lowerView
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    var lowerView: some View {
        ZStack {
            Color.white
            Text("Motivate yourself")
                .font(.system(size: 34, weight: .regular))
                .foregroundColor(.bgMain)
                .padding(EdgeInsets(top: 11, leading: 19, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(height: 365)
        .overlay(
            Circle()
                .fill(.bgMain)
                .frame(width: 328)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -117, trailing: -135))
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        )
        .overlay(
            Button {
                withAnimation {
                    selection += 1
                }
            } label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 64, weight: .regular))
                    .foregroundColor(.white)
            }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: safeAreaInsets.bottom + 16, trailing: 6))
            ,alignment: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    var upperView: some View {
        VStack(spacing: 0) {
            (
                Text("Hello, this is\n")
                    .foregroundColor(.white) +
                Text("MotivateMe")
                    .foregroundColor(.bgSecond) +
                Text(" . Ready\n to get started?")
                    .foregroundColor(.white)
            )
            .font(.system(size: 34, weight: .regular))
            .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
    }
}

struct Register1_Preview: PreviewProvider {
    
    @State static var selection: Int = 0
    
    static var previews: some View {
        
        Register1(selection: $selection)
    }
    
}
