import SwiftUI

struct AnalysisView: View {
    
    @EnvironmentObject var source: Source
    @State var detailsSheet = false
    @State var date = Date()
    @State var showPicker = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgMain.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    header
                    content
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .sheet(isPresented: $detailsSheet, content: {
                AnalysisDetails(show: $detailsSheet, target: source.targetForEdit!)
            })
            .onAppear {
                UIScrollView.appearance().bounces = true
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 19) {
            Text("Analysis")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
           
            HStack(spacing: 0) {
                Button {
                    date = date.addingTimeInterval(-24 * 3600)
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 29, height: 29)
                }
                Text(source.dateToString(date))
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            showPicker = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                Button {
                    date = date.addingTimeInterval(24 * 3600)
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 29, height: 29)
                }
            }
            .padding(.horizontal, 36)
        }
        .padding(.bottom, 20)
    }
    
    private var content: some View {
        ZStack {
            Color.c231231231.ignoresSafeArea()
            
            if source.targets.filter({$0.startDate == source.dateToString(date)}).isEmpty {
                VStack(spacing: 24) {
                    Text("You have no goals for analysis.\nadd an entry in the \"calendar\"\ntab")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.bgMain)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    Image("LongArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 188, height: 325)
                        .padding(.leading, 47)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    notEmpty
                        .padding(.vertical, 20)
                }
            }
        }
        .frame(maxHeight: .infinity)

    }
    
    private var notEmpty: some View {
        VStack(spacing: 15) {
            Text("Not completed")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.bgMain)
            LazyVStack(spacing: 15) {
                ForEach(source.targets.filter{$0.status.id != 2}, id: \.self) { target in
                    targetCard(target)
                        .onTapGesture {
                            source.targetForEdit = target
                            detailsSheet = true
                        }
                }
            }
            Rectangle()
                .fill(Color.bgMain)
                .frame(height: 2)
                .padding(.horizontal, 15)
            Text("Completed")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.bgMain)
            LazyVStack(spacing: 15) {
                ForEach(source.targets.filter{$0.status.id == 2}, id: \.self) { target in
                    completedTargetCard(target)
                        .onTapGesture {
                            source.targetForEdit = target
                            detailsSheet = true
                        }
                }
            }
        }
    }
    
    private func targetCard(_ target: Target) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "record.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(target.status.color)
                .frame(width: 28, height: 28)
            Text(target.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(target.label.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
            Image(systemName: "tag")
                .resizable()
                .scaledToFit()
                .foregroundColor(target.label.color)
                .frame(width: 24, height: 22)
        }
        .padding(.horizontal, 8)
        .frame(height: 44)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 11))
        .padding(.horizontal, 31)
    }
    
    private func completedTargetCard(_ target: Target) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "record.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(target.status.color)
                .frame(width: 28, height: 28)
            Text(target.name)
                .strikethrough()
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(target.label.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
            Image(systemName: "tag")
                .resizable()
                .scaledToFit()
                .foregroundColor(target.label.color)
                .frame(width: 24, height: 22)
        }
        .padding(.horizontal, 8)
        .frame(height: 44)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 11))
        .padding(.horizontal, 36)
    }
}

#Preview {
    AnalysisView()
        .environmentObject(Source())
}
