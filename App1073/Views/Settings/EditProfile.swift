import SwiftUI

struct EditProfile: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    @State var image: Data?
    @State var name = ""
    @State var age = ""
    @State var target = ""
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(Color.bgMain.opacity(0.3))
                    .frame(width: 36, height: 5)
                    .padding(.top, 5)
                header
                    .padding(.horizontal, 8)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            content
        }
        .onAppear {
            image = source.profile?.image ?? nil
            name = source.profile?.name ?? ""
            age = source.profile?.age ?? ""
            target = source.profile?.target ?? ""
        }
    }
    
    private var header: some View {
        Text("Edit profile")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.white)
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
                                .foregroundColor(.white)
                            
                            Text("Back")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                    }
                    Spacer()
                    Button {
                        source.saveProfile(image: image, name: name, age: age, target: target)
                        show = false
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                }
                , alignment: .leading
            )
    }
    
    private var content: some View {
        VStack(spacing: 21) {
            RegisterLargeImageView(imageData: $image, image: setImage(source.profile?.image))
            TextFieldCustom(text: $name, prefix: "Name", placeholder: "Enter")
            TextFieldCustom(text: $age, prefix: "Age", placeholder: "Enter")
            TextFieldCustom(text: $target, prefix: "Target", placeholder: "Enter")
        }
        .padding(.horizontal, 16)
    }
    
    private func setImage(_ data: Data?) -> Image? {
        guard let data = data,
            let image = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: image)
    }
}

struct EditProfile_Preview: PreviewProvider {
    
    @State static var show: Bool = true
    
    static var previews: some View {
        EditProfile(show: $show)
            .environmentObject(Source())
    }
    
}
