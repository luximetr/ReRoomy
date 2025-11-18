import UIKit

@MainActor
public final class Presentation: @MainActor PresentationProtocol {
    
    // MARK: - Init
    
    public init(locale: Locale, time: Time, appearanceSetting: AppearanceSetting) {
        self.locale = locale
        self.time = time
        let window = UIWindow()
        window.windowLevel = .normal
        self.window = window
        self.appearance = Presentation.initializeAppearance(appearanceSetting, window: window)
        self.appearanceSetting = appearanceSetting
    }
    
    // MARK: - Windows
    
    let window: UIWindow
    
    // MARK: - Display
    
    public func show() {
        let viewController = OnboardingPaywallScreenViewController(appearance: appearance, locale: locale, time: time)
//        viewController.view.backgroundColor = .blue
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Appearance
    
    var appearance: Appearance
    var appearanceSetting: AppearanceSetting
    
    func setAppearanceSetting(_ appearanceSetting: AppearanceSetting) {
        self.appearanceSetting = appearanceSetting
        let appearance: Appearance = appearance(appearanceSetting)
        setAppearance(appearance)
    }
    
    private func appearance(_ appearanceSetting: AppearanceSetting) -> Appearance {
        return Presentation.initializeAppearance(appearanceSetting, window: window)
    }
    
    static func initializeAppearance(_ appearanceSetting: AppearanceSetting, window: UIWindow) -> Appearance {
        switch appearanceSetting {
        case .light:
            return CompositeAppearance(fonts: DefaultAppearanceFonts(), colors: LightAppearanceColors(), images: DefaultAppearanceImages())
        case .dark:
            return CompositeAppearance(fonts: DefaultAppearanceFonts(), colors: DarkAppearanceColors(), images: DefaultAppearanceImages())
        case .system:
            let userInterfaceStyle = window.traitCollection.userInterfaceStyle
            switch userInterfaceStyle {
                case .dark: return CompositeAppearance(fonts: DefaultAppearanceFonts(), colors: DarkAppearanceColors(), images: DefaultAppearanceImages())
                default: return CompositeAppearance(fonts: DefaultAppearanceFonts(), colors: LightAppearanceColors(), images: DefaultAppearanceImages())
            }
        }
    }
    
    private func setAppearance(_ appearance: Appearance) {
        self.appearance = appearance
    }
    
    // MARK: - Time
    
    let time: Time
    
    // MARK: - Locale
    
    var locale: Locale
    
    func setLocale(_ locale: Locale) {
        self.locale = locale
    }
}
