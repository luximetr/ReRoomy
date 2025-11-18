import UIKit

extension OnboardingPaywallScreenViewController {
final class ScreenView: StatusBarScreenView {
    
    // MARK: - Init
    
    init(appearance: Appearance) {
        super.init(appearance: appearance)
    }
    
    // MARK: - Subviews
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        backgroundColor = .brown
    }
    
    // MARK: - Layout
}
}
