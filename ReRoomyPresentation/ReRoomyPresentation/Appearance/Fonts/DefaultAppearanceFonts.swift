import UIKit

struct DefaultAppearanceFonts: AppearanceFonts {
    
    func primary(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
}
