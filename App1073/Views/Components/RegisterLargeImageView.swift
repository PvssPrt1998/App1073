import PhotosUI
import SwiftUI

struct RegisterLargeImageView: View {
   
    @Binding var imageData: Data?
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
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
                Image(systemName: "plus")
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 167, height: 167)
                    .background(Color.c217217217)
                    .clipShape(.circle)
            }
        }
        .frame(width: 167, height: 167)
        .clipShape(.circle)
        .onTapGesture {
            showingImagePicker = true
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
                .ignoresSafeArea()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        imageData = inputImage.pngData()
    }
}
