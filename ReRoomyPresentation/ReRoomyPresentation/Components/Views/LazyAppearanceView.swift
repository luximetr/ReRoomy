import UIKit
import AUIKit

class LazyAppearanceView: AUIView {
    
    // MARK: - Init
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    // MARK: - Appearance
    
    var appearance: Appearance?
    
    func setAppearance(_ appearance: Appearance) {
        self.appearance = appearance
    }
    
}
