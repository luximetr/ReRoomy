import UIKit

struct LightAppearanceColors: AppearanceColors {
    
    let statusBarStyle = UIStatusBarStyle.darkContent
    let primaryBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let secondaryBackground = UIColor(red: 0.16, green: 0.21, blue: 0.37, alpha: 1)
    let secondaryBackgroundGradient: [CGColor] = [
        UIColor(red: 0.23, green: 0.29, blue: 0.46, alpha: 1).cgColor,
        UIColor(red: 0.34, green: 0.51, blue: 1.00, alpha: 1).cgColor
    ]
    let primaryContrastBackground = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    let primaryActionBackground = UIColor(red: 0.167, green: 0.404, blue: 0.758, alpha: 1)
    let primaryActionText = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    let successActionBackground = UIColor(red: 0.349, green: 0.773, blue: 0.494, alpha: 1)
    let successActionDisabledBackground = UIColor(red: 0.38, green: 0.42, blue: 0.55, alpha: 1)
    let primaryText = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    let secondaryText = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
    let primaryContrastText = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let successText: UIColor = UIColor(red: 0, green: 0.89, blue: 0.52, alpha: 1)
    
}
