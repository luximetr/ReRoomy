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
        screenView.longTermPlanButton.addTarget(self, action: #selector(longTermPlanButtonTouchUpInside), for: .touchUpInside)
        screenView.regularTermPlanButton.addTarget(self, action: #selector(regularTermPlanButtonTouchUpInside), for: .touchUpInside)
        screenView.trialToggleButton.addTarget(self, action: #selector(trialToggleButtonTouchUpInside), for: .touchUpInside)
        screenView.trialToggleButton.addTarget(self, action: #selector(trialToggleButtonValueChanged), for: .valueChanged)
        setLocalizedContent()
        loadUnlimitedPlans()
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
        screenView.showPurchaseFooter(title: localizer.localizeText("purchaseFooterTitle"))
        screenView.regularTermPlanButton.titleLabel.text = localizer.localizeText("weeklyPlanTrialDuration")
        screenView.regularTermPlanButton.subtitleLabel.text = localizer.localizeText("weeklyPlanPrice", "0")
        screenView.regularTermPlanButton.priceLabel.text = localizer.localizeText("weeklyPlanTrialPrice")
        screenView.longTermPlanButton.titleLabel.text = localizer.localizeText("yearlyPlanTitle")
        screenView.longTermPlanButton.subtitleLabel.text = localizer.localizeText("yearlyPlanPriceTitle")
        screenView.longTermPlanButton.discountLabel.text = localizer.localizeText("yearlyPlanDiscount", "85%")
        screenView.trialToggleButton.titleLabel.text = localizer.localizeText("trialFooterTitle")
        screenView.continueButton.title = "Test"
    }
    
    // MARK: - Plans
    
    var getUnlimitedPlans: ((@escaping (UnlimitedPlans) -> Void) -> Void)?
    
    private func loadUnlimitedPlans() {
        guard let getUnlimitedPlans = getUnlimitedPlans else { return }
        getUnlimitedPlans({ [weak self] plans in
            guard let self = self else { return }
            self.showUnlimitedPlans(plans)
        })
    }
    
    private func showUnlimitedPlans(_ plans: UnlimitedPlans) {
        screenView.longTermPlanButton.subtitleLabel.text = plans.yearly.priceFormatted
        screenView.regularTermPlanButton.subtitleLabel.text = localizer.localizeText("weeklyPlanPrice", plans.weekly.priceFormatted)
    }

    // MARK: - Long term plan

    @objc private func longTermPlanButtonTouchUpInside() {
        screenView.longTermPlanButton.isSelected.toggle()
    }
    
    // MARK: - Regular term plan
    
    @objc private func regularTermPlanButtonTouchUpInside() {
        screenView.regularTermPlanButton.isSelected.toggle()
    }

    // MARK: - Trial

    @objc private func trialToggleButtonTouchUpInside() {
        screenView.trialToggleButton.set(isSelected: !screenView.trialToggleButton.isSelected, animated: true)
    }

    @objc private func trialToggleButtonValueChanged() {
        print("value changed")
    }
}
