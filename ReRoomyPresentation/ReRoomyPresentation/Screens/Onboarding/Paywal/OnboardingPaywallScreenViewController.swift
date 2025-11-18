import UIKit

class OnboardingPaywallScreenViewController: StatusBarScreenViewController {
    
    // MARK: - Init
    
    override init(appearance: Appearance, locale: Locale, time: Time) {
        super.init(appearance: appearance, locale: locale, time: time)
    }
    
    // MARK: - View
    
    private var screenView: ScreenView {
        return view as! ScreenView
    }
    
    override func loadView() {
        view = ScreenView(appearance: appearance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedContent()
    }
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
    }
    
    // MARK: Localizer
    
    private lazy var localizer: Localizer = {
        let localizer = LocalizerBasedOnStringsTableName(locale: locale, stringsTableName: "OnboardingPaywallScreenStrings")
        return localizer
    }()
    
    override func setLocale(_ locale: Locale) {
        super.setLocale(locale)
        setLocalizedContent()
    }
    
    private func setLocalizedContent() {
        screenView.titleLabel.text = localizer.localizeText("title")
        screenView.subtitleLabel.text = localizer.localizeText("subtitle")
    }
}
