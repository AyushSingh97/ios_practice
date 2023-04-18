import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

/*
 ```
 let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
 imageView.load(urlString: "https://example.com/image.jpg", placeholderImage: UIImage(named: "placeholder"))
 ```
 */
extension UIImageView {
    func load(urlString: String, placeholderImage: UIImage? = nil) {
        // Show placeholder image
        self.image = placeholderImage
        
        // Check if the image is already cached
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Cache the downloaded image
                    imageCache.setObject(image, forKey: urlString as AnyObject)
                    
                    self?.image = image
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = placeholderImage
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            }
        }
    }
}
