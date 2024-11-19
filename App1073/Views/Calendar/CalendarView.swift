import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var source: Source
    @State var date: Date = Date()
    
    @State var addTargetSheet = false
    @State var editTargetSheet = false
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                content
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if source.targets.isEmpty {
                Text("You don't have a single goal.\nClick on the plus sign and it\nwill appear here")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.bgMain)
                    .padding(.bottom, 125)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                Image("emptyArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 83)
                        .padding(.trailing, 70)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            
            Button {
                addTargetSheet = true
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.bgSecond)
                    .padding(4)
                    .frame(width: 45, height: 45)
                    .background(Color.bgMain)
                    .clipShape(.circle)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 19, trailing: 12))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .onAppear {
            UIScrollView.appearance().bounces = true
        }
        .sheet(isPresented: $addTargetSheet, content: {
            AddTarget(show: $addTargetSheet, startDate: dateToString(date))
        })
        .sheet(isPresented: $editTargetSheet, content: {
            EditTarget(show: $editTargetSheet, target: source.targetForEdit!)
        })
    }
    
    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    private var header: some View {
        Text("Calendar")
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.white)
            .padding(.bottom, 5)
    }
    
    private var content: some View {
        ZStack {
            Color.c231231231
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    DatePicker("Enter your birthday", selection: $date, displayedComponents: [.date])
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .frame(height: 318)
                                    .padding(.horizontal, 15)
                                    .background(Color.white)
                                    .clipShape(.rect(cornerRadius: 22))
                                    .shadow(color: .black.opacity(0.1), radius: 54, y: 9)
                                    .padding(EdgeInsets(top: 23, leading: 36, bottom: 0, trailing: 36))
                    if !source.targets.isEmpty {
                        notEmpty
                            .padding(.top, 20)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    private var notEmpty: some View {
        VStack(spacing: 15) {
            Text("Active")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.bgMain)
            LazyVStack(spacing: 15) {
                ForEach(source.targets.filter{$0.status.id != 2}, id: \.self) { target in
                    targetCard(target)
                        .onTapGesture {
                            source.targetForEdit = target
                            editTargetSheet = true
                        }
                }
            }
            Rectangle()
                .fill(Color.bgMain)
                .frame(height: 2)
                .padding(.horizontal, 16)
            Text("Completed")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.bgMain)
            LazyVStack(spacing: 15) {
                ForEach(source.targets.filter{$0.status.id == 2}, id: \.self) { target in
                    completedTargetCard(target)
                        .onTapGesture {
                            source.targetForEdit = target
                            editTargetSheet = true
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
        .padding(.horizontal, 36)
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
    
    private var empty: some View {
        Text("You don't have a single goal.\nClick on the plus sign and it will\nappear here")
            .font(.system(size: 22, weight: .regular))
            .foregroundColor(.bgMain)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    CalendarView()
        .environmentObject(Source())
}
