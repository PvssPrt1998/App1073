import SwiftUI

struct AddTarget: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    @State var name: String = ""
    @State var startDate: String
    @State var endDate: String = ""
    @State var description: String = ""
    
    @State var selectedStatus: Status?
    @State var selectedLabel: Label?
    
    init(show: Binding<Bool>, startDate: String) {
        self._show = show
        self.startDate = startDate
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.c231231231.ignoresSafeArea()
                VStack(spacing: 0) {
                    header
                        .padding(.horizontal, 8)
                        .background(Color.white)
                    ScrollView(.vertical, showsIndicators: false) {
                        content
                            .padding(.bottom, 10)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.c606067.opacity(0.3))
                .frame(width: 36, height: 5)
                .padding(.top, 5)
            Text("Calendar")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .overlay(
                    HStack {
                        Button {
                            show = false
                        } label: {
                            HStack(spacing: 3) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Text("Back")
                                    .font(.system(size: 17, weight: .regular))
                            }
                            .padding(.horizontal, 8)
                        }
                        Spacer()
                        Button {
                            source.saveTarget(name: name, startDate: startDate, endDate: endDate, description: description, status: selectedStatus!, label: selectedLabel!)
                            show = false
                        } label: {
                            Text("Done")
                                .font(.system(size: 17, weight: .regular))
                        }
                        .disabled(disabled)
                        .opacity(disabled ? 0.5 : 1)
                        .padding(.horizontal, 8)
                    }
                    , alignment: .leading
            )
        }
    }
    
    private var disabled: Bool {
        name == "" || startDate.count < 10 || description == "" || selectedStatus == nil || selectedLabel == nil
    }
    
    private var textFields: some View {
        VStack(spacing: 0) {
            TargetTextField(text: $name, prefix: "Name", placeholder: "Enter name")
            Divider()
                .padding(.leading, 16)
            TargetTextField(text: $startDate, prefix: "Start date", placeholder: "Enter date")
                .keyboardType(.numberPad)
                .onChange(of: startDate, perform: { newValue in
                    startDateValidation(newValue)
                })
            Divider()
                .padding(.leading, 16)
            TargetTextField(text: $endDate, prefix: "End date", placeholder: "Enter date")
                .keyboardType(.numberPad)
                .onChange(of: endDate, perform: { newValue in
                    endDateValidation(newValue)
                })
            Divider()
                .padding(.leading, 16)
            TargetTextField(text: $description, prefix: "Description", placeholder: "Enter description")
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal, 26)
    }
    
    private var labels: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Status")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink {
                    AddStatusView()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .frame(width: 22, height: 22)
                }
            }
            statusesCollection
                .padding(.top, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Labels")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink {
                    AddLabelView()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .frame(width: 22, height: 22)
                }
            }
            .padding(.top, 44)
            
            labelsCollection
                .padding(.top, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.horizontal, 44)
    }
    
    private var statusesCollection: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(0..<source.statuses.count, id: \.self) { index in
                    if index % 2 == 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "record.circle.fill")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(source.statuses[index].color)
                            Text(source.statuses[index].name)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(source.statuses[index].id == selectedStatus?.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .onTapGesture {
                            if selectedStatus?.id == source.statuses[index].id {
                                selectedStatus = nil
                            } else {
                                selectedStatus = source.statuses[index]
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            VStack(alignment: .leading, spacing: 15) {
                ForEach(0..<source.statuses.count, id: \.self) { index in
                    if index % 2 != 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "record.circle.fill")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(source.statuses[index].color)
                            Text(source.statuses[index].name)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(source.statuses[index].id == selectedStatus?.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .onTapGesture {
                            if selectedStatus?.id == source.statuses[index].id {
                                selectedStatus = nil
                            } else {
                                selectedStatus = source.statuses[index]
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var labelsCollection: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(0..<source.labels.count, id: \.self) { index in
                    if index % 2 == 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "tag")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(source.labels[index].color)
                            Text(source.labels[index].name)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(source.labels[index].id == selectedLabel?.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .onTapGesture {
                            if selectedLabel?.id == source.labels[index].id {
                                selectedLabel = nil
                            } else {
                                selectedLabel = source.labels[index]
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            VStack(alignment: .leading, spacing: 15) {
                ForEach(0..<source.labels.count, id: \.self) { index in
                    if index % 2 != 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "tag")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(source.labels[index].color)
                            Text(source.labels[index].name)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(source.labels[index].id == selectedLabel?.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .onTapGesture {
                            if selectedLabel?.id == source.labels[index].id {
                                selectedLabel = nil
                            } else {
                                selectedLabel = source.labels[index]
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            Text("Target")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .frame(height: 74)
            textFields
            labels.padding(.top, 47)
        }
    }
    
    private func startDateValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            var filterIterable = filtered.makeIterator()
            var index = 0
            var value = ""
            while let c = filterIterable.next() {
                if index == 0 || index == 1 || index == 3 || index == 5 || index == 6 || index == 7 {
                    value = value + "\(c)"
                }
                if index == 2 || index == 4 {
                    value = value + ".\(c)"
                }
                index += 1
            }
            startDate = value
        } else  {
            startDate = ""
        }
    }
    
    private func endDateValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            var filterIterable = filtered.makeIterator()
            var index = 0
            var value = ""
            while let c = filterIterable.next() {
                if index == 0 || index == 1 || index == 3 || index == 5 || index == 6 || index == 7 {
                    value = value + "\(c)"
                }
                if index == 2 || index == 4 {
                    value = value + ".\(c)"
                }
                index += 1
            }
            endDate = value
        } else  {
            endDate = ""
        }
    }
}

struct AddTarget_Preview: PreviewProvider {
    
    @State static var show: Bool = true
    
    static var previews: some View {
        AddTarget(show: $show, startDate: "05.05.1990")
            .environmentObject(Source())
    }
}
