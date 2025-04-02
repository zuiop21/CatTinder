import SwiftUI

struct CachedAsyncImage: View {
    let url: String
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        ImageLoader.shared.loadImage(for: url) { loadedImage in
                            self.image = loadedImage
                        }
                    }
            }
        }
    }
}



