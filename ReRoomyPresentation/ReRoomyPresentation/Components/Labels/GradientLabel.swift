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
        set { contentLabel.text = newValue }
        get { contentLabel.text }
    }
    
    // MARK: - Gradient
    
    var gradientColors: [CGColor] {
        set { gradientLayer.colors = newValue }
        get { gradientLayer.colors as? [CGColor] ?? [] }
    }
    
    var gradientStartPoint: CGPoint {
        set { gradientLayer.startPoint = newValue }
        get { gradientLayer.startPoint }
    }
    
    var gradientEndPoint: CGPoint {
        set { gradientLayer.endPoint = newValue }
        get { gradientLayer.endPoint }
    }
    
    // MARK: - Formatting
    
    override var font: UIFont! {
        set { contentLabel.font = newValue }
        get { contentLabel.font }
    }
    
    override var textColor: UIColor! {
        set { contentLabel.textColor = newValue }
        get { contentLabel.textColor }
    }
    
    override var textAlignment: NSTextAlignment {
        set { contentLabel.textAlignment = newValue }
        get { contentLabel.textAlignment }
    }
    
    // MARK: - Size
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let size = contentLabel.sizeThatFits(size)
        return size
    }
    
}
