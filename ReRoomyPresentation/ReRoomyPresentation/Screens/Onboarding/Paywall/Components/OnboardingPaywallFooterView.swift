import UIKit

extension OnboardingPaywallScreenViewController {
class FooterView: LazyAppearanceView {
    
    // MARK: - Subviews
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        addSubview(imageView)
        setupImageView()
        addSubview(titleLabel)
        setupTitleLabel()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutTitleLabel()
    }
    
    private static let imageViewWidthHeight: CGFloat = 24
    
    private func layoutImageView() {
        let x: CGFloat = 0
        let height = Self.imageViewWidthHeight
        let width = Self.imageViewWidthHeight
        let y = (bounds.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        imageView.frame = frame
    }
    
    private static let titleLabelLeading: CGFloat = 2
    private static let titleLabelTop: CGFloat = 5
    private static let titleLabelBottom: CGFloat = 5
    
    private func layoutTitleLabel() {
        let y = Self.titleLabelTop
        let x = imageView.frame.maxX + Self.titleLabelLeading
        let width = bounds.width - x
        let height = bounds.height - y - Self.titleLabelBottom
        let frame = CGRect(x: x, y: y, width: width, height: height)
        titleLabel.frame = frame
    }
    
    // MARK: - Size
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let titleLabelWidthToFit = size.width - Self.imageViewWidthHeight - Self.titleLabelLeading
        let titleLabelHeightToFit = size.height - Self.titleLabelTop - Self.titleLabelBottom
        let titleLabelSizeThatFits = titleLabel.sizeThatFits(CGSize(width: titleLabelWidthToFit, height: titleLabelHeightToFit))
        let width = Self.imageViewWidthHeight + Self.titleLabelLeading + titleLabelSizeThatFits.width
        let height = Self.titleLabelTop + Self.titleLabelBottom + titleLabelSizeThatFits.height
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Appearance
    
    override func setAppearance(_ appearance: any Appearance) {
        super.setAppearance(appearance)
        imageView.tintColor = appearance.colors.successText
        titleLabel.textColor = appearance.colors.primaryText
        titleLabel.font = appearance.fonts.primaryRounded(size: 12, weight: .medium)
    }
}
}
