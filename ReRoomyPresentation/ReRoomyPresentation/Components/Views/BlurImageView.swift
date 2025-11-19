import UIKit
import AUIKit
import CoreImage

class BlurImageView: AUIView {
    
    // MARK: - Subviews
    
    private let imageView = UIImageView()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        addSubview(imageView)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    // MARK: - Content
    
    override var contentMode: UIView.ContentMode {
        set { imageView.contentMode = newValue }
        get { imageView.contentMode }
    }
    
    // MARK: - Image
    
    func setImage(_ image: UIImage, blurRadius: CGFloat) {
        do {
            try trySetBluredImage(image, blurRadius: blurRadius)
        } catch {
            imageView.image = image
        }
    }
    
    private func trySetBluredImage(_ image: UIImage?, blurRadius: CGFloat) throws {
        guard let image = image else { return }
        guard blurRadius > 0 else {
            imageView.image = image
            return
        }
        guard let ciInput = CIImage(image: image) else { throw Error.unableToSetImage }
        guard let filter = CIFilter(name: "CIGaussianBlur") else { throw Error.unableToSetImage }
        filter.setValue(ciInput, forKey: kCIInputImageKey)
        filter.setValue(blurRadius, forKey: kCIInputRadiusKey)
        
        guard let outputImage = filter.outputImage else { throw Error.unableToSetImage }
        let context = CIContext(options: nil)
        let rect = ciInput.extent
        guard let cgImage = context.createCGImage(outputImage.cropped(to: rect), from: rect) else { throw Error.unableToSetImage }
        imageView.image = UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
    
    private enum Error: Swift.Error {
        case unableToSetImage
    }
}
