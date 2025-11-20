import UIKit

class TextFilledButton: LazyAppearanceButton {
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
        backgroundColor = appearance.colors.primaryActionBackground
        setTitleColor(appearance.colors.primaryActionText, for: .normal)
        titleLabel?.font = appearance.fonts.primary(size: 16, weight: .bold)
    }
    
    // MARK: - Highlighted
    
    override var isHighlighted: Bool {
        willSet {
            showIsHighlighted(newValue)
        }
    }
    
    private func showIsHighlighted(_ isHighlightedUpdated: Bool) {
        guard let titleLabel = titleLabel else { return }
        let targetAlpha: CGFloat = isHighlightedUpdated ? 0.8 : 1.0
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseInOut],
            animations: {
                titleLabel.alpha = targetAlpha
            },
            completion: nil
        )
    }
}
