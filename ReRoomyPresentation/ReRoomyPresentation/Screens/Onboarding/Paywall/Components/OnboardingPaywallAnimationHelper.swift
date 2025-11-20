import UIKit

extension OnboardingPaywallScreenViewController {
final class AnimationHelper {
    
    static func animateBorder(
        of layer: CALayer,
        to borderWidth: CGFloat,
        color: CGColor?,
        duration: TimeInterval = 0.3
    ) {
        let borderAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderAnimation.fromValue = layer.borderWidth
        borderAnimation.toValue = borderWidth
        borderAnimation.duration = duration
        borderAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(borderAnimation, forKey: "borderWidth")
        layer.borderWidth = borderWidth
        if let color = color {
            layer.borderColor = color
        }
    }
    
    static func animateOpacity(
        of layer: CALayer,
        to opacity: Float,
        duration: TimeInterval = 0.3,
        delegate: CAAnimationDelegate? = nil
    ) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = layer.opacity
        opacityAnimation.toValue = opacity
        opacityAnimation.duration = duration
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        if let delegate = delegate {
            opacityAnimation.delegate = delegate
        }
        layer.add(opacityAnimation, forKey: "opacity")
        layer.opacity = opacity
    }
    
    @MainActor
    static func animateTextColor(
        of labels: [UILabel],
        to color: UIColor,
        duration: TimeInterval = 0.3
    ) {
        labels.forEach { label in
            UIView.transition(
                with: label,
                duration: duration,
                options: [.transitionCrossDissolve, .allowUserInteraction]
            ) {
                label.textColor = color
            }
        }
    }
    
    @MainActor
    static func animateViewsAlpha(
        of views: [UIView],
        to alpha: Float,
        duration: TimeInterval = 0.3
    ) {
        views.forEach { view in
            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.fromValue = view.layer.presentation()?.opacity ?? view.layer.opacity
            alphaAnimation.toValue = alpha
            alphaAnimation.duration = duration
            alphaAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            view.layer.add(alphaAnimation, forKey: "opacity")
            view.layer.opacity = alpha
        }
    }
}
}
