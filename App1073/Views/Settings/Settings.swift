import SwiftUI

struct Settings: View {
    
    @State var showEditProfile: Bool = false
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var source: Source
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Settings")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            showEditProfile = true
                        } label: {
                            Image(systemName: "pencil.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.bgSecond)
                                .padding(4)
                                .frame(width: 45, height: 45)
                                .background(Color.c011075)
                                .clipShape(.circle)
                        }
                        ,alignment: .trailing
                    )
                    .padding(EdgeInsets(top: safeAreaInsets.top, leading: 16, bottom: 0, trailing: 16))
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        upperView
                        lowerView
                            .padding(.bottom, 10)
                    }
                }
                .padding(.top, 10)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfile(show: $showEditProfile)
        }
    }
    
    private var upperView: some View {
        ZStack {
            Color.bgMain
            
            VStack(spacing: 21) {
                image(setImage(source.profile?.image))
                    .padding(.top, 21)
                if source.profile != nil {
                    VStack(spacing: 12) {
                        if let name = source.profile?.name {
                            if name != "" {
                                text(name, prefix: "Name")
                            }
                        }
                        if let age = source.profile?.age {
                            if age != "" {
                                text(age, prefix: "Age")
                            }
                        }
                        if let target = source.profile?.target {
                            if target != "" {
                                text(target, prefix: "Target")
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 23)
            .padding(.horizontal, 16)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .layoutPriority(1)
    }
    
    private var lowerView: some View {
        ZStack {
            Color.white
            VStack(spacing: 24) {
                Button {
                    actionSheet()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                        Text("Share app")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 48)
                    .background(Color.bgMain)
                    .clipShape(.rect(cornerRadius: 12))
                }
                Button {
                    if let url = URL(string: "https://www.termsfeed.com/live/35b054bf-1025-42c4-a1f3-60043228b11f") {
                        openURL(url)
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image("bookPages")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                        Text("Terms of use")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 48)
                    .background(Color.bgMain)
                    .clipShape(.rect(cornerRadius: 12))
                }
                Button {
                    if let url = URL(string: "https://www.termsfeed.com/live/4b2efbbf-9195-4876-841a-5505025f244e") {
                        openURL(url)
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "shield")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white)
                        Text("Privacy")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 48)
                    .background(Color.bgMain)
                    .clipShape(.rect(cornerRadius: 12))
                }
            }
            .padding(EdgeInsets(top: 23, leading: 16, bottom: UITabBarController().height + 40, trailing: 16))
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/motivateme-achieve-your-best/id6738186815")  else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        if #available(iOS 15.0, *) {
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController?
            .present(activityVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func setImage(_ data: Data?) -> Image? {
        guard let data = data,
            let image = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: image)
    }
    
    @ViewBuilder private func image(_ image: Image?) -> some View {
        ZStack {
            Color.white.opacity(0.1)
            if let image = image {
                ZStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                .frame(width: 167, height: 167)
                .clipShape(.circle)
            } else {
                Image(systemName: "camera")
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 167, height: 167)
                    .background(Color.c217217217)
                    .clipShape(.circle)
            }
        }
        .frame(width: 167, height: 167)
        .clipShape(.circle)
    }
    
    private func text(_ text: String, prefix: String) -> some View {
        HStack(spacing: 10) {
            Text(prefix)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.bgSecond)
            Text(text)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)
                .autocorrectionDisabled(true)
                .accentColor(.white)
        }
        .padding(.leading, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 44)
        .background(Color.white.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.c224231237, lineWidth: 1)
        )
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct Settings_Preview: PreviewProvider {

    static var previews: some View {
        Settings()
            .environmentObject(Source())
    }
    
}

