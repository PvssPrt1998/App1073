import SwiftUI

struct QuotesView: View {
    
    @AppStorage("firstQ") var firstQ = true
    @EnvironmentObject var source: Source
    @State var selection = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgMain.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    header
                    ZStack {
                        content
                        if firstQ {
                            guideView
                                .onTapGesture {
                                    firstQ = false
                                }
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        firstQ = false
                                    }
                                }
                        }
                    }
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    private var guideView: some View {
        ZStack {
            Color.black.opacity(0.5)
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 64, weight: .regular))
                        .foregroundColor(.bgSecond)
                    Image(systemName: "hand.draw")
                        .font(.system(size: 64, weight: .regular))
                        .foregroundColor(.bgSecond)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 64, weight: .regular))
                        .foregroundColor(.bgSecond)
                }
                
                Text("Swipe left and right to\nwatch motivational\nposts")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.bgSecond)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var header: some View {
        Text("Quotes")
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .overlay(
                NavigationLink {
                    FavoriteQuotesView()
                } label: {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.bgSecond)
                        .padding(4)
                        .frame(width: 45, height: 45)
                        .background(Color.c011075)
                        .clipShape(.circle)
                }
                    .padding(.trailing, 15)
                ,alignment: .trailing
            )
            .padding(.bottom, 10)
    }
    
    private var content: some View {
        ZStack {
            Color.c231231231.ignoresSafeArea()
            
            TabView(selection: $selection) {
                ForEach(0..<source.motivates.count, id: \.self) { index in
                    Image(source.motivates[index].image)
                        .resizable()
                        .overlay(
                            Image(systemName: source.motivates[index].favorite ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.bgSecond)
                                .padding(8)
                                .frame(width: 45, height: 45)
                                .background(Color.c011075)
                                .clipShape(.circle)
                                .onTapGesture {
                                    source.motivateToggle(index)
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 12))
                            ,alignment: .bottomTrailing
                        )
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            print("Onapp")
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

#Preview {
    QuotesView()
        .environmentObject(Source())
}
