import UIKit

extension OnboardingPaywallScreenViewController {
final class ScreenView: StatusBarScreenView {
    
    // MARK: - Init
    
    init(appearance: Appearance) {
        super.init(appearance: appearance)
    }
    
    // MARK: - Subviews
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let bannerImageView = UIImageView()
    let longTermPlanButton = LongTermPlanButton()
    let regularTermPlanButton = RegularTermPlanButton()
    let trialToggleButton = TrialToggleButton()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        addSubview(titleLabel)
        setupTitleLabel()
        addSubview(subtitleLabel)
        setupSubtitleLabel()
        addSubview(bannerImageView)
        setupBannerImageView()
        addSubview(longTermPlanButton)
        addSubview(regularTermPlanButton)
        addSubview(trialToggleButton)
        setAppearance(appearance)
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
    }
    
    private func setupBannerImageView() {
        bannerImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutSubtitleLabel()
        layoutBannerImageView()
        layoutLongTermPlanButton()
        layoutRegularTermPlanButton()
        layoutTrialToggleButton()
    }
    
    private static let contentLeadingTrailing: CGFloat = 16
    
    private static let titleLabelTop: CGFloat = 24
    
    private func layoutTitleLabel() {
        let x = Self.contentLeadingTrailing
        let y = statusBarView.frame.maxY + Self.titleLabelTop
        let width = bounds.width - x - Self.contentLeadingTrailing
        let sizeToFit = CGSize(width: width, height: .greatestFiniteMagnitude)
        let sizeThatFits = titleLabel.sizeThatFits(sizeToFit)
        let height = sizeThatFits.height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        titleLabel.frame = frame
    }
    
    private static let subtitleLabelTop: CGFloat = 12
    
    private func layoutSubtitleLabel() {
        let x = titleLabel.frame.minX
        let width = titleLabel.frame.width
        let y = titleLabel.frame.maxY + Self.subtitleLabelTop
        let sizeToFit = CGSize(width: width, height: .greatestFiniteMagnitude)
        let sizeThatFits = subtitleLabel.sizeThatFits(sizeToFit)
        let height = sizeThatFits.height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        subtitleLabel.frame = frame
    }
    
    private func layoutBannerImageView() {
        let x: CGFloat = 0
        let y = subtitleLabel.frame.maxY + 20
        let width = bounds.width
        let aspectRation: CGFloat = 0.7511210762
        let height = width * aspectRation
        let frame = CGRect(x: x, y: y, width: width, height: height)
        bannerImageView.frame = frame
    }
    
    private func layoutLongTermPlanButton() {
        let x = Self.contentLeadingTrailing
        let width = bounds.width - Self.contentLeadingTrailing * 2
        let height = longTermPlanButton.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let y = bannerImageView.frame.maxY - 16
        let frame = CGRect(x: x, y: y, width: width, height: height)
        longTermPlanButton.frame = frame
    }
    
    private func layoutRegularTermPlanButton() {
        let x = Self.contentLeadingTrailing
        let width = bounds.width - Self.contentLeadingTrailing * 2
        let height = regularTermPlanButton.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let y = longTermPlanButton.frame.maxY + 16
        let frame = CGRect(x: x, y: y, width: width, height: height)
        regularTermPlanButton.frame = frame
    }
    
    private func layoutTrialToggleButton() {
        let x = Self.contentLeadingTrailing
        let width = bounds.width - Self.contentLeadingTrailing * 2
        let height = trialToggleButton.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let y = regularTermPlanButton.frame.maxY + 16
        let frame = CGRect(x: x, y: y, width: width, height: height)
        trialToggleButton.frame = frame
    }
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
        backgroundColor = appearance.colors.primaryBackground
        titleLabel.textColor = appearance.colors.primaryText
        titleLabel.font = appearance.fonts.primary(size: 40, weight: .heavy)
        subtitleLabel.textColor = appearance.colors.primaryText
        subtitleLabel.font = appearance.fonts.primary(size: 18, weight: .medium)
        bannerImageView.image = appearance.images.paywallBanner
        longTermPlanButton.setAppearance(appearance)
        regularTermPlanButton.setAppearance(appearance)
        trialToggleButton.setAppearance(appearance)
    }
}
}
