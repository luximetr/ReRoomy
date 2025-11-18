import UIKit
import AUIKit

class StatusBarScreenView: AUIView {
    
    // MARK: - Elements
    
    let statusBarView: UIView
    
    // MARK: - Appearance
    
    var appearance: Appearance
    
    func setAppearance(_ appearance: Appearance) {
        self.appearance = appearance
        statusBarView.backgroundColor = appearance.colors.primaryBackground
        backgroundColor = appearance.colors.primaryBackground
    }
    
    // MARK: - Initialization
    
    init(frame: CGRect = .zero, appearance: Appearance, statusBarView: UIView = UIView()) {
        self.appearance = appearance
        self.statusBarView = statusBarView
        super.init(frame: frame)
    }
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        addSubview(statusBarView)
        setAppearance(appearance)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutStatusBarView()
    }
    
    func layoutStatusBarView() {
        let x: CGFloat = 0
        let y: CGFloat = 0
        let width = bounds.width
        let height = safeAreaInsets.top
        statusBarView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
