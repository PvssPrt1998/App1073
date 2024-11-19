import SwiftUI

struct Register2: View {
    
    @EnvironmentObject var source: Source
    
    @Binding var selection: Int
    @Binding var screen: Screen
    
    @State var image: Data?
    @State var name = ""
    @State var age = ""
    @State var target = ""
    
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
    
    private var upperView: some View {
        ZStack {
            Color.bgMain
            
            VStack(spacing: 38) {
                RegisterImageView(imageData: $image)
                VStack(spacing: 12) {
                    TextFieldCustom(text: $name, prefix: "Name", placeholder: "Enter")
                    TextFieldCustom(text: $age, prefix: "Age", placeholder: "Enter")
                        .keyboardType(.numberPad)
                        .onChange(of: age, perform: { newValue in
                            ageValidation(newValue)
                        })
                    TextFieldCustom(text: $target, prefix: "Target", placeholder: "Enter")
                }
            }
            .padding(EdgeInsets(top: 148, leading: 16, bottom: 0, trailing: 16))
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var lowerView: some View {
        ZStack {
            Color.white
            Button {
                action()
            } label: {
                Text("Continue")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.bgMain)
                    .clipShape(.rect(cornerRadius: 12))
            }.padding(.horizontal, 16)
        }
        .frame(height: 169)
    }
    
    private func ageValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            age = filtered
        } else  {
            age = ""
        }
    }
    
    func action() {
        source.saveProfile(image: image, name: name, age: age, target: target)
        withAnimation {
            screen = .main
        }
    }
}

struct Register2_Preview: PreviewProvider {
    
    @State static var selection: Int = 0
    @State static var screen: Screen = .register
    
    static var previews: some View {
        Register2(selection: $selection, screen: $screen)
            .environmentObject(Source())
    }
    
}
