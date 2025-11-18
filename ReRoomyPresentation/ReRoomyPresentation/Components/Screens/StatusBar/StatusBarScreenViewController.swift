import UIKit
import AUIKit

class StatusBarScreenViewController: AUIStatusBarScreenViewController {
    
    // MARK: - Initialization
    
    init(appearance: Appearance, locale: Locale, time: Time) {
        self.appearance = appearance
        self.locale = locale
        self.time = time
        super.init()
        self.statusBarStyle = appearance.colors.statusBarStyle
    }
  
    // MARK: - Appearance
    
    var appearance: Appearance
    
    func setAppearance(_ appearance: Appearance) {
        self.appearance = appearance
        self.statusBarStyle = appearance.colors.statusBarStyle
        didSetStatusBarStyle()
    }
    
    // MARK: - Localization
    
    var locale: Locale
    
    func setLocale(_ locale: Locale) {
        self.locale = locale
    }
    
    // MARK: - Time
    
    var time: Time
    
    func setTime(_ time: Time) {
        self.time = time
    }
    
}
