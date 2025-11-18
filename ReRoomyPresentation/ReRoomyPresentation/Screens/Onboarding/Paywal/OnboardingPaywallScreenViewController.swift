import UIKit

class OnboardingPaywallScreenViewController: StatusBarScreenViewController {
    
    // MARK: - Init
    
    override init(appearance: Appearance, locale: Locale, time: Time) {
        super.init(appearance: appearance, locale: locale, time: time)
    }
    
    // MARK: - View
    
    override func loadView() {
        view = ScreenView(appearance: appearance)
    }
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
    }
}
