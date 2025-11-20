import UIKit
import AUIKit

class GradientView: AUIView {
    
    // MARK: - Subviews
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.frame = bounds
        CATransaction.commit()
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
    
    var gradientType: CAGradientLayerType {
        set { gradientLayer.type = newValue }
        get { gradientLayer.type }
    }
    
    var gradientLocations: [NSNumber]? {
        set { gradientLayer.locations = newValue }
        get { gradientLayer.locations }
    }
    
}
