import UIKit
/// This is a singleton instance of NSCache class, created for caching images in the project
let imageCache = NSCache<AnyObject, AnyObject>() // The key and value types are specified as AnyObject, indicating that any type can be used as the key or value in the cache.
/**
 This is an extension on the UIImageView class that provides an easy way to load images asynchronously from a URL and handle caching of images using NSCache.
 
 ### Usage Example: ###
 ````
 let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
 imageView.load(urlString: "https://example.com/image.jpg", placeholderImage: UIImage(named: "placeholder"))
 ````
 
 - Parameters:
    - urlString: The URL string of the image that needs to be loaded.
    - placeholderImage: An optional UIImage that will be shown as a placeholder image while the image is being loaded.
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
        
        // Add an activity indicator to show that the image is being loaded
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        
        // Load the image asynchronously from the URL
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // Cache the downloaded image
                imageCache.setObject(image, forKey: urlString as AnyObject)
                
                // Update the image view with the downloaded image
                DispatchQueue.main.async {
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
