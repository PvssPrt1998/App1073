import SwiftUI

struct AddStatusView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var source: Source
    @State var name = ""
    @State var color = Color.purple
    
    var body: some View {
        ZStack {
            Color.c231231231.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 8)
                    .background(Color.white)
                content
                    .padding(EdgeInsets(top: 30, leading: 26, bottom: 0, trailing: 26))
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.c606067.opacity(0.3))
                .frame(width: 36, height: 5)
                .padding(.top, 5)
            Text("Status")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .overlay(
                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
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
                            source.saveStatus(name: name, color: color)
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                                .font(.system(size: 17, weight: .regular))
                        }
                        .disabled(name == "" || name == "Done")
                        .opacity(name == "" || name == "Done" ? 0.5 : 1)
                        .padding(.horizontal, 8)
                    }
                    , alignment: .leading
            )
        }
    }
    
    private var content: some View {
        VStack(spacing: 12) {
            TargetTextField(text: $name, prefix: "Name", placeholder: "Status name")
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 10))
            HStack {
                Text("# Choose")
                    .font(.system(size: 14, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.c151151151)
                
                ColorPicker("Colors", selection: $color)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 44)
            .padding(.horizontal, 16)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 10))
//            
//            .onTapGesture {
//                guard let colorComponents = UIColor(Color.bgMain).cgColor.components else { return }
//                print(colorComponents)
//            }
            
        }
    }
}

#Preview {
    AddStatusView()
        .environmentObject(Source())
}
