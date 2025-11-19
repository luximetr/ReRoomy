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
        showSelectedPlanSelection(.yearly, animated: false)
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
        showSelectedPlanSelection(.yearly, animated: false)
    }
    
    private func setLocalizedContent() {
        screenView.titleLabel.text = localizer.localizeText("title")
        screenView.subtitleLabel.text = localizer.localizeText("subtitle")
        screenView.showPurchaseFooter(title: localizer.localizeText("purchaseFooterTitle"))
        screenView.regularTermPlanButton.titleLabel.text = localizer.localizeText("weeklyPlanTrialDuration")
        screenView.regularTermPlanButton.subtitleLabel.text = localizer.localizeText("weeklyPlanPrice", "0")
        screenView.regularTermPlanButton.priceLabel.text = localizer.localizeText("weeklyPlanTrialPrice")
        screenView.longTermPlanButton.discountLabel.text = localizer.localizeText("yearlyPlanDiscount", "85%")
        screenView.longTermPlanButton.titleLabel.text = localizer.localizeText("yearlyPlanTitle")
        screenView.longTermPlanButton.subtitleLabel.text = localizer.localizeText("yearlyPlanPrice", "0")
        screenView.longTermPlanButton.pricePerDayValueLabel.text = "$0.1"
        screenView.longTermPlanButton.pricePerDayTitleLabel.text = localizer.localizeText("yearlyPlanPriceTitle")
        screenView.trialToggleButton.titleLabel.text = localizer.localizeText("trialFooterTitle")
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
        screenView.longTermPlanButton.subtitleLabel.text = localizer.localizeText("yearlyPlanPrice", plans.yearly.priceFormatted)
        screenView.regularTermPlanButton.subtitleLabel.text = localizer.localizeText("weeklyPlanPrice", plans.weekly.priceFormatted)
    }
    
    // MARK: - Plan option
    
    private enum PlanSelection {
        case yearly
        case weekly
    }
    
    private var selectedPlanSelection: PlanSelection = .yearly
    
    private func setSelectedPlanSelection(_ selection: PlanSelection, animated: Bool) {
        selectedPlanSelection = selection
        showSelectedPlanSelection(selection, animated: animated)
    }
    
    private func showSelectedPlanSelection(_ option: PlanSelection, animated: Bool) {
        switch option {
        case .yearly:
            showYearlyPlanSelected(animated: animated)
        case .weekly:
            showWeeklyPlanSelected(animated: animated)
        }
    }

    // MARK: - Long term plan

    @objc private func longTermPlanButtonTouchUpInside() {
        guard selectedPlanSelection != .yearly else { return }
        selectedPlanSelection = .yearly
        showSelectedPlanSelection(selectedPlanSelection, animated: true)
    }
    
    private func showYearlyPlanSelected(animated: Bool) {
        screenView.longTermPlanButton.isSelected = true
        screenView.regularTermPlanButton.isSelected = false
        screenView.trialToggleButton.set(isSelected: false, animated: animated)
        screenView.continueButton.title = localizer.localizeText("continueButtonPurchaseTitle")
        screenView.showPurchaseFooter(title: localizer.localizeText("purchaseFooterTitle"))
    }
    
    // MARK: - Regular term plan
    
    @objc private func regularTermPlanButtonTouchUpInside() {
        guard selectedPlanSelection != .weekly else { return }
        selectedPlanSelection = .weekly
        showSelectedPlanSelection(selectedPlanSelection, animated: true)
    }
    
    private func showWeeklyPlanSelected(animated: Bool) {
        screenView.longTermPlanButton.isSelected = false
        screenView.regularTermPlanButton.isSelected = true
        screenView.trialToggleButton.set(isSelected: true, animated: animated)
        screenView.continueButton.title = localizer.localizeText("continueButtonTrialTitle")
        screenView.showTrialFooter(title: localizer.localizeText("trialFooterTitle"))
    }

    // MARK: - Trial

    @objc private func trialToggleButtonTouchUpInside() {
        togglePlanSelection(animated: true)
    }

    @objc private func trialToggleButtonValueChanged() {
        togglePlanSelection(animated: true)
    }
    
    private func togglePlanSelection(animated: Bool) {
        var updatedSelectedPlanSelection: PlanSelection = selectedPlanSelection
        switch selectedPlanSelection {
        case .yearly:
            updatedSelectedPlanSelection = .weekly
        case .weekly:
            updatedSelectedPlanSelection = .yearly
        }
        setSelectedPlanSelection(updatedSelectedPlanSelection, animated: animated)
    }
}
