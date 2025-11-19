import UIKit
import AUIKit

class GradientLabel: AUILabel {
    
    // MARK: - Subviews
    
    private let gradientLayer = CAGradientLayer()
    private let contentLabel = UILabel()
    
    // MARK: - Init
    
    override func setup() {
        super.setup()
        layer.addSublayer(gradientLayer)
        addSubview(contentLabel)
        mask = contentLabel
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.frame = bounds
        gradientLayer.frame = bounds
    }
    
    // MARK: - Text
    
    override var text: String? {
        get { contentLabel.text }
        set { contentLabel.text = newValue }
    }
    
    // MARK: - Gradient
    
    var gradientColors: [CGColor] {
        get { gradientLayer.colors as? [CGColor] ?? [] }
        set { gradientLayer.colors = newValue }
    }
    
    var gradientStartPoint: CGPoint {
        get { gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }
    
    var gradientEndPoint: CGPoint {
        get { gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }
    
    // MARK: - Text formatting
    
    override var font: UIFont! {
        get { contentLabel.font }
        set { contentLabel.font = newValue }
    }
    
    override var textColor: UIColor! {
        get { contentLabel.textColor }
        set { contentLabel.textColor = newValue }
    }
    
    override var textAlignment: NSTextAlignment {
        get { contentLabel.textAlignment }
        set { contentLabel.textAlignment = newValue }
    }
    
    // MARK: - Size
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let size = contentLabel.sizeThatFits(size)
        return size
    }
    
}
