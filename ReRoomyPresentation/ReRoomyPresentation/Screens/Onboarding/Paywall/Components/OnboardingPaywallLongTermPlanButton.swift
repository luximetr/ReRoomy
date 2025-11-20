import UIKit

extension OnboardingPaywallScreenViewController {
class LongTermPlanButton: LazyAppearanceButton {
    
    // MARK: - Subviews
    
    private let gradientLayer = CAGradientLayer()
    private let _titleLabel = UILabel()
    override var titleLabel: UILabel { _titleLabel }
    private let _subtitleLabel = UILabel()
    override var subtitleLabel: UILabel { _subtitleLabel }
    let discountBackgroundView = UIView()
    let discountLabel = UILabel()
    let pricePerDayValueLabel = UILabel()
    let pricePerDayTitleLabel = UILabel()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupGradientLayer()
        addSubview(discountBackgroundView)
        setupDiscountBackgroundView()
        addSubview(discountLabel)
        setupDiscountLabel()
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(pricePerDayValueLabel)
        setupPricePerDayValueLabel()
        addSubview(pricePerDayTitleLabel)
        setupPricePerDayTitleLabel()
    }
    
    private func setupGradientLayer() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    private func setupDiscountBackgroundView() {
        discountBackgroundView.isUserInteractionEnabled = false
    }
    
    private func setupDiscountLabel() {
        discountLabel.textAlignment = .center
    }
    
    private func setupPricePerDayValueLabel() {
        pricePerDayValueLabel.textAlignment = .right
    }
    
    private func setupPricePerDayTitleLabel() {
        pricePerDayTitleLabel.textAlignment = .right
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutGradientLayer()
        layoutDiscountLabel()
        layoutDiscountBackgroundView()
        layoutTitleLabel()
        layoutSubtitleLabel()
        layoutPricePerDayValueLabel()
        layoutPricePerDayTitleLabel()
    }
    
    private func layoutGradientLayer() {
        gradientLayer.frame = bounds
    }
    
    private static let discountLabelLeadingTrailing: CGFloat = 16
    private static let discountLabelTopBottom: CGFloat = 6
    private static let discountLabelMinHeight: CGFloat = 15
    
    private func layoutDiscountLabel() {
        let x = Self.discountLabelLeadingTrailing
        let width = bounds.width - x - Self.discountLabelLeadingTrailing
        let y = Self.discountLabelTopBottom
        let heightThatFits = discountLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let height = max(Self.discountLabelMinHeight, heightThatFits)
        let frame = CGRect(x: x, y: y, width: width, height: height)
        discountLabel.frame = frame
    }
    
    private func layoutDiscountBackgroundView() {
        let x: CGFloat = 0
        let y: CGFloat = 0
        let width = bounds.width
        let height = discountLabel.frame.height + Self.discountLabelTopBottom * 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        discountBackgroundView.frame = frame
    }
    
    
    private static let titleLabelTop: CGFloat = 12
    private static let titleLabelLeadingTrailing: CGFloat = 16
    private static let titleLabelMinHeight: CGFloat = 26
    
    private func layoutTitleLabel() {
        let x = Self.titleLabelLeadingTrailing
        let y = discountBackgroundView.frame.maxY + Self.titleLabelTop
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
    
    private static let pricePerDayValueLabelTop: CGFloat = 12
    private static let pricePerDayValueLabelTrailing: CGFloat = 16
    private static let pricePerDayValueLabelHeight: CGFloat = 26
    
    private func layoutPricePerDayValueLabel() {
        let y = discountBackgroundView.frame.maxY + Self.pricePerDayValueLabelTop
        let height = Self.pricePerDayValueLabelHeight
        let width = pricePerDayValueLabel.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: height)).width
        let x = bounds.width - width - Self.pricePerDayValueLabelTrailing
        let frame = CGRect(x: x, y: y, width: width, height: height)
        pricePerDayValueLabel.frame = frame
    }
    
    private static let pricePerDayTitleLabelTop: CGFloat = 4
    private static let pricePerDayTitleLabelHeight: CGFloat = 20
    
    private func layoutPricePerDayTitleLabel() {
        let y = pricePerDayValueLabel.frame.maxY + Self.pricePerDayTitleLabelTop
        let height = Self.pricePerDayTitleLabelHeight
        let width = pricePerDayTitleLabel.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: height)).width
        let x = bounds.width - width - Self.pricePerDayValueLabelTrailing
        let frame = CGRect(x: x, y: y, width: width, height: height)
        pricePerDayTitleLabel.frame = frame
    }
    
    // MARK: - Size
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = size.width
        
        var height: CGFloat = 0
        
        let discountLabelWidthToFit = width - Self.discountLabelLeadingTrailing * 2
        let discountLabelHeight = discountLabel.sizeThatFits(CGSize(width: discountLabelWidthToFit, height: .greatestFiniteMagnitude)).height
        height += discountLabelHeight + Self.discountLabelTopBottom * 2

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
        discountBackgroundView.backgroundColor = appearance.colors.primaryContrastBackground
        discountLabel.textColor = appearance.colors.primaryContrastText
        discountLabel.font = appearance.fonts.primary(size: 14, weight: .semibold)
        titleLabel.font = appearance.fonts.primary(size: 24, weight: .semibold)
        subtitleLabel.font = appearance.fonts.primary(size: 18, weight: .medium)
        pricePerDayValueLabel.font = appearance.fonts.primary(size: 24, weight: .semibold)
        pricePerDayTitleLabel.font = appearance.fonts.primary(size: 18, weight: .medium)
        showIsSelected(isSelected)
    }
    
    // MARK: - Highlighted
    
    override var isHighlighted: Bool {
        willSet {
            showIsHighlighted(newValue)
        }
    }
    
    private func showIsHighlighted(_ isHighlightedUpdated: Bool) {
        let highligtingViews = [discountLabel, titleLabel, subtitleLabel, pricePerDayValueLabel, pricePerDayTitleLabel]
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
        pricePerDayValueLabel.textColor = appearance.colors.primaryText
        pricePerDayTitleLabel.textColor = appearance.colors.primaryText
    }
    
    private func showDeselected(appearance: any Appearance) {
        layer.borderWidth = 0
        layer.borderColor = nil
        gradientLayer.removeFromSuperlayer()
        titleLabel.textColor = appearance.colors.secondaryText
        subtitleLabel.textColor = appearance.colors.secondaryText
        pricePerDayValueLabel.textColor = appearance.colors.secondaryText
        pricePerDayTitleLabel.textColor = appearance.colors.secondaryText
    }
}
}
