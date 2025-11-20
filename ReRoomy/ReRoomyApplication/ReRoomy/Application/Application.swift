import UIKit
import ReRoomyPresentation

class Application: NSObject, UIApplicationDelegate, UIWindowSceneDelegate {
    
    // MARK: - Life cycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = Application.self
        return configuration
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        do {
            try initialize(window: window)
            presentation.showOnboarding()
        } catch {
            print("Failed to initialize app: \(error)")
        }
    }
    
    // MARK: - Initialize
    
    func initialize(window: UIWindow) throws {
        try initializeLocale()
        initializeTime()
        try initializePresentation(window: window)
    }
    
    // MARK: - Presentation
    
    var window: UIWindow?
    var presentation: PresentationProtocol!
    
    func initializePresentation(window: UIWindow) throws {
        let presentationAppearanceSetting: PresentationAppearanceSetting = .dark
        let presentationLocale = LocaleMapper.mapToPresentation(locale: locale)
        var presentation: PresentationProtocol = Presentation(window: window, locale: presentationLocale, time: time, appearanceSetting: presentationAppearanceSetting)
        weak var weakSelf = self
        presentation.getUnlimitedPlans = weakSelf?.presentationUnlimitedPlans
        presentation.purchaseUnlimitedPlan = weakSelf?.presentationPurchaseUnlimitedPlan
        self.presentation = presentation
    }
    
    // MARK: - Calendar
    
    var calendar: Calendar!
    
    // MARK: - Time
    
    var time: Time!
    
    private func initializeTime() {
        let currentCalendar = Calendar.current
        calendar = currentCalendar
        calendar.firstWeekday = currentCalendar.firstWeekday
        let time = ClosuresTime(
            currentDeviceTime: { Date() },
            currentDeviceCalendar: { self.calendar },
            currentDeviceTimeZone: { TimeZone.current }
        )
        self.time = time
    }
    
    // MARK: - Locale
    
    var locale: Locale!
    
    private func initializeLocale() throws {
        let locale = Locale(language: .english)
        self.locale = locale
    }
    
    // MARK: - Store
    
    private var _storeKitProvider: StoreKitProviderProtocol?
    var storeKitProvider: StoreKitProviderProtocol {
        if let storeKitProvider = _storeKitProvider {
            return storeKitProvider
        }
        if #available(iOS 15.0, *) {
            let storeKitProvider = StoreKit2Provider()
            _storeKitProvider = storeKitProvider
        } else {
            
        }
        return storeKitProvider
    }
}
