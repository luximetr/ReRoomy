import UIKit

extension OnboardingPaywallScreenViewController {
class RegularTermPlanButton: LazyAppearanceButton {
    
    // MARK: - Subviews
    
    private let gradientLayer = CAGradientLayer()
    private let _titleLabel = UILabel()
    override var titleLabel: UILabel { _titleLabel }
    private let _subtitleLabel = UILabel()
    override var subtitleLabel: UILabel { _subtitleLabel }
    let priceLabel = UILabel()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(priceLabel)
        setupPriceLabel()
    }
    
    private func setupPriceLabel() {
        priceLabel.textAlignment = .right
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutGradientLayer()
        layoutTitleLabel()
        layoutSubtitleLabel()
        layoutPriceLabel()
    }
    
    private func layoutGradientLayer() {
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    private static let titleLabelTop: CGFloat = 12
    private static let titleLabelLeadingTrailing: CGFloat = 16
    private static let titleLabelMinHeight: CGFloat = 26
    
    private func layoutTitleLabel() {
        let x = Self.titleLabelLeadingTrailing
        let y = Self.titleLabelTop
        let width = bounds.width - x - Self.titleLabelLeadingTrailing
        let heightThatFits = titleLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let height = max(heightThatFits, Self.titleLabelMinHeight)
        let frame = CGRect(x: x, y: y, width: width, height: height)
        titleLabel.frame = frame
    }
    
    private static let subtitleLabelTop: CGFloat = 4
    private static let subtitleLabelMinHeight: CGFloat = 20
    private static let subtitleLabelBottom: CGFloat = 12
    
    private func layoutSubtitleLabel() {
        let x = titleLabel.frame.minX
        let y = titleLabel.frame.maxY + Self.subtitleLabelTop
        let width = titleLabel.frame.width
        let heightThatFits = subtitleLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let height = max(heightThatFits, Self.subtitleLabelMinHeight)
        let frame = CGRect(x: x, y: y, width: width, height: height)
        subtitleLabel.frame = frame
    }
    
    private static let priceLabelTop: CGFloat = 12
    private static let priceLabelTrailing: CGFloat = 16
    private static let priceLabelHeight: CGFloat = 26
    
    private func layoutPriceLabel() {
        let height = Self.priceLabelHeight
        let y = (bounds.height - height) / 2
        let width = priceLabel.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: height)).width
        let x = bounds.width - width - Self.priceLabelTrailing
        let frame = CGRect(x: x, y: y, width: width, height: height)
        priceLabel.frame = frame
    }
    
    // MARK: - Size
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = size.width
        
        var height: CGFloat = 0
        
        let titleLabelWidthToFit = width - Self.titleLabelLeadingTrailing * 2
        let titleLabelHeightThatFits = titleLabel.sizeThatFits(CGSize(width: titleLabelWidthToFit, height: .greatestFiniteMagnitude)).height
        let titleLabelHeight = max(titleLabelHeightThatFits, Self.titleLabelMinHeight)
        height += titleLabelHeight + Self.titleLabelTop

        let subtitleLabelWidthToFit = titleLabelWidthToFit
        let subtitleLabelHeightThatFits = subtitleLabel.sizeThatFits(CGSize(width: subtitleLabelWidthToFit, height: .greatestFiniteMagnitude)).height
        let subtitleLabelHeight = max(subtitleLabelHeightThatFits, Self.subtitleLabelMinHeight)
        height += subtitleLabelHeight + Self.subtitleLabelTop + Self.subtitleLabelBottom
        
        let takenSize = CGSize(width: width, height: height)
        return takenSize
    }
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
        backgroundColor = appearance.colors.secondaryBackground
        gradientLayer.colors = appearance.colors.secondaryBackgroundGradient
        titleLabel.font = appearance.fonts.primary(size: 24, weight: .semibold)
        subtitleLabel.font = appearance.fonts.primary(size: 18, weight: .medium)
        priceLabel.font = appearance.fonts.primary(size: 20, weight: .semibold)
        showIsSelected(isSelected)
    }
    
    // MARK: - Highlighted
    
    override var isHighlighted: Bool {
        willSet {
            showIsHighlighted(newValue)
        }
    }
    
    private func showIsHighlighted(_ isHighlightedUpdated: Bool) {
        let highligtingViews = [titleLabel, subtitleLabel, priceLabel]
        let targetAlpha: CGFloat = isHighlightedUpdated ? 0.6 : 1.0
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseInOut],
            animations: {
                highligtingViews.forEach({ $0.alpha = targetAlpha })
            },
            completion: nil
        )
    }
    
    // MARK: - Selected
    
    override var isSelected: Bool {
        willSet {
            showIsSelected(newValue)
        }
    }
    
    private func showIsSelected(_ isSelectedUpdated: Bool) {
        guard let appearance = appearance else { return }
        if isSelectedUpdated {
            showSelected(appearance: appearance)
        } else {
            showDeselected(appearance: appearance)
        }
    }
    
    private func showSelected(appearance: any Appearance) {
        layer.borderWidth = 1
        layer.borderColor = appearance.colors.primaryContrastBackground.cgColor
        layer.insertSublayer(gradientLayer, at: 0)
        titleLabel.textColor = appearance.colors.primaryText
        subtitleLabel.textColor = appearance.colors.primaryText
        priceLabel.textColor = appearance.colors.primaryText
    }
    
    private func showDeselected(appearance: any Appearance) {
        layer.borderWidth = 0
        layer.borderColor = nil
        gradientLayer.removeFromSuperlayer()
        titleLabel.textColor = appearance.colors.secondaryText
        subtitleLabel.textColor = appearance.colors.secondaryText
        priceLabel.textColor = appearance.colors.secondaryText
    }
}
}
