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
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        addSubview(titleLabel)
        setupTitleLabel()
        addSubview(subtitleLabel)
        setupSubtitleLabel()
        setAppearance(appearance)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Title"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.text = "Subtitle"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTitleLabel()
        layoutSubtitleLabel()
    }
    
    private static let titleLabelTop: CGFloat = 24
    private static let titleLabelLeadingTrailing: CGFloat = 16
    
    private func layoutTitleLabel() {
        let x = Self.titleLabelLeadingTrailing
        let y = statusBarView.frame.maxY + Self.titleLabelTop
        let width = bounds.width - x - Self.titleLabelLeadingTrailing
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
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
        backgroundColor = appearance.colors.primaryBackground
        titleLabel.font = appearance.fonts.primary(size: 40, weight: .heavy)
        subtitleLabel.font = appearance.fonts.primary(size: 18, weight: .medium)
    }
}
}
