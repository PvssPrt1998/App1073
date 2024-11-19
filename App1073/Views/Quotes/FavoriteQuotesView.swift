import SwiftUI

struct FavoriteQuotesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var source: Source
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                content
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var content: some View {
        ZStack {
            Color.c231231231.ignoresSafeArea()
            
            if source.motivates.filter({$0.favorite}).isEmpty {
                Text("Like the post and it will appear\nhere")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.bgMain)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.fixed(138), spacing: 38),GridItem(.fixed(138))], spacing: 10) {
                        ForEach(source.motivates.filter({$0.favorite}), id: \.self) { motivate in
                            VStack(spacing: 10) {
                                Image(motivate.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 138, height: 232)
                                    .clipped()
                                    .clipShape(.rect(cornerRadius: 20))
                                Text(motivate.date)
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.top, 26)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            UIScrollView.appearance().bounces = true
            print(";e;")
        }
    }
    
    private var header: some View {
        Text("Quotes")
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .overlay(
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("ArrowShape")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.bgSecond)
                        .padding(4)
                        .frame(width: 45, height: 45)
                        .background(Color.c011075)
                        .clipShape(.circle)
                }
                .padding(.leading, 15)
                ,alignment: .leading
            )
            .padding(.bottom, 10)
    }
}

#Preview {
    FavoriteQuotesView()
        .environmentObject(Source())
}
