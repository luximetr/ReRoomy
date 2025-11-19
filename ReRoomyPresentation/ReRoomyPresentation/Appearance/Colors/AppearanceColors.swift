import UIKit

protocol AppearanceColors {
    
    var statusBarStyle: UIStatusBarStyle { get }
    var primaryBackground: UIColor { get }
    var secondaryBackground: UIColor { get }
    var secondaryBackgroundGradient: [CGColor] { get }
    var primaryContrastBackground: UIColor { get }
    var primaryActionBackground: UIColor { get }
    var primaryActionText: UIColor { get }
    var successActionBackground: UIColor { get }
    var primaryText: UIColor { get }
    var secondaryText: UIColor { get }
    var primaryContrastText: UIColor { get }
    
}
