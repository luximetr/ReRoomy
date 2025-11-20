import UIKit

extension OnboardingPaywallScreenViewController {
final class TrialToggleButton: LazyAppearanceButton {
    
    // MARK: - Subviews
    
    private let backgroundGradientView = GradientView()
    private let _titleLabel = UILabel()
    override var titleLabel: UILabel { _titleLabel }
    private let toggle = UISwitch()

    // MARK: - Setup

    override func setup() {
        super.setup()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupBackgroundGradientLayer()
        addSubview(titleLabel)
        addSubview(toggle)
        setupToggle()
    }
    
    private func setupBackgroundGradientLayer() {
        backgroundGradientView.gradientStartPoint = CGPoint(x: 0, y: 0.5)
        backgroundGradientView.gradientEndPoint = CGPoint(x: 1, y: 0.5)
    }
    
    private func setupToggle() {
        toggle.addTarget(self, action: #selector(toggleValueChanged), for: .valueChanged)
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackgroundGradientLayer()
        layoutTitleLabel()
        layoutToggle()
    }
    
    private func layoutBackgroundGradientLayer() {
        backgroundGradientView.frame = bounds
    }

    private static let titleLabelLeading: CGFloat = 16
    private static let titleLabelTopBottom: CGFloat = 16
    private static let titleLabelTrailing: CGFloat = 8
    private static let titleLabelMinHeight: CGFloat = 20

    private func layoutTitleLabel() {
        let x: CGFloat = Self.titleLabelLeading
        let width = bounds.width - Self.titleLabelLeading - Self.titleLabelTrailing - toggle.sizeThatFits(bounds.size).width - Self.toggleTrailing
        let y: CGFloat = Self.titleLabelTopBottom
        let height = bounds.height - Self.titleLabelTopBottom * 2
        titleLabel.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private static let toggleTrailing: CGFloat = 16

    private func layoutToggle() {
        let size = toggle.sizeThatFits(bounds.size)
        let width = size.width
        let height = size.height
        let x = bounds.width - width - Self.toggleTrailing
        let y = (bounds.height - height) / 2
        toggle.frame = CGRect(x: x, y: y, width: width, height: height)
        toggle.layer.cornerRadius = height / 2
    }

    // MARK: - Size

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let titleLabelAvailableWidth = size.width - toggle.intrinsicContentSize.width - Self.titleLabelLeading - Self.titleLabelTrailing
        let titleLabelSizeThatFits = titleLabel.sizeThatFits(CGSize(width: titleLabelAvailableWidth, height: .greatestFiniteMagnitude))
        let titleLabelHeight = max(titleLabelSizeThatFits.height, Self.titleLabelMinHeight)
        
        let height = titleLabelHeight + Self.titleLabelTopBottom * 2
        let width = titleLabel.intrinsicContentSize.width + toggle.intrinsicContentSize.width
        
        return CGSize(width: width, height: height)
    }

    // MARK: - Appearance

    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
        backgroundColor = appearance.colors.secondaryBackground
        backgroundGradientView.gradientColors = appearance.colors.secondaryBackgroundGradient
        titleLabel.font = appearance.fonts.primary(size: 18, weight: .medium)
        titleLabel.textColor = appearance.colors.primaryText
        toggle.tintColor = appearance.colors.successActionDisabledBackground
        toggle.backgroundColor = toggle.tintColor
        toggle.onTintColor = appearance.colors.successActionBackground
        showIsSelected(isSelected, animated: false)
    }
    
    // MARK: - Highlighted
    
    override var isHighlighted: Bool {
        willSet {
            showIsHighlighted(newValue)
        }
    }
    
    private func showIsHighlighted(_ isHighlightedUpdated: Bool) {
        let targetAlpha: CGFloat = isHighlightedUpdated ? 0.6 : 1.0
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseInOut],
            animations: { [weak self] in
                guard let self = self else { return }
                self.titleLabel.alpha = targetAlpha
            },
            completion: nil
        )
    }
    
    // MARK: - Selected
    
    override var isSelected: Bool {
        willSet {
            showIsSelected(newValue, animated: false)
        }
    }
    
    func set(isSelected: Bool, animated: Bool) {
        super.isSelected = isSelected
        showIsSelected(isSelected, animated: animated)
    }
    
    private func showIsSelected(_ isSelectedUpdated: Bool, animated: Bool) {
        guard let appearance = appearance else { return }
        if isSelectedUpdated {
            showSelected(appearance: appearance, animated: animated)
        } else {
            showDeselected(appearance: appearance, animated: animated)
        }
    }
    
    private func showSelected(appearance: any Appearance, animated: Bool) {
        backgroundGradientView.isHidden = false
        titleLabel.textColor = appearance.colors.primaryText
        toggle.setOn(true, animated: animated)
    }
    
    private func showDeselected(appearance: any Appearance, animated: Bool) {
        backgroundGradientView.isHidden = true
        titleLabel.textColor = appearance.colors.secondaryText
        toggle.setOn(false, animated: animated)
    }
    
    @objc private func toggleValueChanged() {
        set(isSelected: toggle.isOn, animated: true)
        sendActions(for: .valueChanged)
    }
}
}
