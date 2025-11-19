import UIKit
import AUIKit

class LazyAppearanceButton: AUIButton {
    
    // MARK: - Initialization
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    // MARK: - Appearance
    
    var appearance: Appearance?
    
    func setAppearance(_ appearance: Appearance) {
        self.appearance = appearance
    }
    
}
