import SwiftUI

class ImageLoader {
    static let shared = ImageLoader()
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func loadImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            guard let imageUrl = URL(string: url) else {
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }

           
                self?.imageCache.setObject(image, forKey: url as NSString)

                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }
}
