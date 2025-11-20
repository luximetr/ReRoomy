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
        screenView.continueButton.addTarget(self, action: #selector(continueButtonTouchUpInside), for: .touchUpInside)
        setLocalizedContent()
        showSelectedPlanSelection(.longTerm, animated: false)
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
        showSelectedPlanSelection(selectedPlanSelection, animated: false)
    }
    
    private func setLocalizedContent() {
        screenView.titleLabel.text = localizer.localizeText("title")
        screenView.subtitleLabel.text = localizer.localizeText("subtitle")
        screenView.showPurchaseFooter(title: localizer.localizeText("purchaseFooterTitle"))
        screenView.regularTermPlanButton.titleLabel.text = localizer.localizeText("regularTermPlanTrialDuration")
        screenView.regularTermPlanButton.subtitleLabel.text = localizer.localizeText("regularTermPlanPrice", "0")
        screenView.regularTermPlanButton.priceLabel.text = localizer.localizeText("regularTermPlanTrialPrice")
        screenView.longTermPlanButton.discountLabel.text = localizer.localizeText("longTermPlanDiscount", "85%")
        screenView.longTermPlanButton.titleLabel.text = localizer.localizeText("longTermPlanTitle")
        screenView.longTermPlanButton.subtitleLabel.text = localizer.localizeText("longTermPlanPrice", "0")
        screenView.longTermPlanButton.pricePerDayValueLabel.text = "$0.1"
        screenView.longTermPlanButton.pricePerDayTitleLabel.text = localizer.localizeText("longTermPlanPriceTitle")
        screenView.trialToggleButton.titleLabel.text = localizer.localizeText("trialFooterTitle")
    }
    
    // MARK: - Plans
    
    private var unlimitedPlans: UnlimitedPlans?
    var getUnlimitedPlans: ((@escaping (UnlimitedPlans) -> Void) -> Void)?
    
    private func loadUnlimitedPlans() {
        guard let getUnlimitedPlans = getUnlimitedPlans else { return }
        getUnlimitedPlans({ [weak self] plans in
            guard let self = self else { return }
            self.unlimitedPlans = plans
            self.showUnlimitedPlans(plans)
        })
    }
    
    private func showUnlimitedPlans(_ plans: UnlimitedPlans) {
        screenView.longTermPlanButton.subtitleLabel.text = localizer.localizeText("longTermPlanPrice", plans.yearly.priceFormatted)
        screenView.regularTermPlanButton.subtitleLabel.text = localizer.localizeText("regularTermPlanPrice", plans.weekly.priceFormatted)
    }
    
    // MARK: - Plan option
    
    private enum PlanSelection {
        case longTerm
        case regularTerm
    }
    
    private var selectedPlanSelection: PlanSelection = .longTerm
    
    private func setSelectedPlanSelection(_ selection: PlanSelection, animated: Bool) {
        selectedPlanSelection = selection
        showSelectedPlanSelection(selection, animated: animated)
    }
    
    private func showSelectedPlanSelection(_ option: PlanSelection, animated: Bool) {
        switch option {
        case .longTerm:
            showLongTermPlanSelected(animated: animated)
        case .regularTerm:
            showRegularTermPlanSelected(animated: animated)
        }
    }

    // MARK: - Long term plan

    @objc private func longTermPlanButtonTouchUpInside() {
        guard selectedPlanSelection != .longTerm else { return }
        selectedPlanSelection = .longTerm
        showSelectedPlanSelection(selectedPlanSelection, animated: true)
    }
    
    private func showLongTermPlanSelected(animated: Bool) {
        screenView.longTermPlanButton.isSelected = true
        screenView.regularTermPlanButton.isSelected = false
        screenView.trialToggleButton.set(isSelected: false, animated: animated)
        screenView.continueButton.title = localizer.localizeText("continueButtonPurchaseTitle")
        screenView.showPurchaseFooter(title: localizer.localizeText("purchaseFooterTitle"))
    }
    
    // MARK: - Regular term plan
    
    @objc private func regularTermPlanButtonTouchUpInside() {
        guard selectedPlanSelection != .regularTerm else { return }
        selectedPlanSelection = .regularTerm
        showSelectedPlanSelection(selectedPlanSelection, animated: true)
    }
    
    private func showRegularTermPlanSelected(animated: Bool) {
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
        case .longTerm:
            updatedSelectedPlanSelection = .regularTerm
        case .regularTerm:
            updatedSelectedPlanSelection = .longTerm
        }
        setSelectedPlanSelection(updatedSelectedPlanSelection, animated: animated)
    }
    
    // MARK: - Continue
    
    @objc private func continueButtonTouchUpInside() {
        switch selectedPlanSelection {
        case .longTerm:
            longTermPlanContinueButtonTouchUpInside()
        case .regularTerm:
            regularTermPlanContinueButtonTouchUpInside()
        }
    }
    
    var onPurchaseUnlimitedPlan: ((UnlimitedPlan) -> Void)?
    
    private func longTermPlanContinueButtonTouchUpInside() {
        guard let onPurchaseUnlimitedPlan = onPurchaseUnlimitedPlan else { return }
        guard let yearlyPlan = unlimitedPlans?.yearly else { return }
        onPurchaseUnlimitedPlan(yearlyPlan)
    }
    
    private func regularTermPlanContinueButtonTouchUpInside() {
        guard let onPurchaseUnlimitedPlan = onPurchaseUnlimitedPlan else { return }
        guard let weeklyPlan = unlimitedPlans?.weekly else { return }
        onPurchaseUnlimitedPlan(weeklyPlan)
    }
}
