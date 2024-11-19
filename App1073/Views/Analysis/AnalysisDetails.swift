import SwiftUI

struct AnalysisDetails: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    let target: Target
    
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
            Text("Analysis")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .overlay(
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
                    , alignment: .leading
            )
        }
    }
    
    private func detailTextView(_ text: String, prefix: String) -> some View {
        HStack(spacing: 0) {
            Text(prefix)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 100)
            Text(text)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .autocorrectionDisabled(true)
                .accentColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
        .frame(height: 44)
    }
    
    private var textFields: some View {
        VStack(spacing: 0) {
            detailTextView(target.name, prefix: "Name")
            Divider()
                .padding(.leading, 16)
            detailTextView(target.startDate, prefix: "Start date")
            Divider()
                .padding(.leading, 16)
            detailTextView(target.endDate == "" ? "Not indicated" : target.endDate, prefix: "End date")
            Divider()
                .padding(.leading, 16)
            detailTextView(target.description, prefix: "Description")
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal, 26)
    }
    
    private var labels: some View {
        VStack(spacing: 0) {
            Text("Status")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            statusesCollection
                .padding(.top, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Labels")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
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
                        .background(source.statuses[index].id == target.status.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
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
                        .background(source.statuses[index].id == target.status.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
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
                        .background(source.labels[index].id == target.label.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
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
                        .background(source.labels[index].id == target.label.id ? Color.black.opacity(0.12) : Color.white)
                        .clipShape(.rect(cornerRadius: 12))
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
}

struct AnalysisDetails_Preview: PreviewProvider {
    
    @State static var show: Bool = true
    
    static var previews: some View {
        AnalysisDetails(show: $show, target: Target(uuid: UUID(), name: "123", startDate: "05.05.1990", endDate: "12.12.1212", description: "descr", status: Status(id: 0, name: "To do", color: .red), label: Label(id: 0, name: "School", color: .red)))
            .environmentObject(Source())
    }
}
