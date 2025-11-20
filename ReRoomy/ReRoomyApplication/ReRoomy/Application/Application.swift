import UIKit
import ReRoomyPresentation

class Application: NSObject, UIApplicationDelegate {
    
    // MARK: - Life cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            try initialize()
            presentation.showOnboarding()
        } catch {
            print(error)
        }
        return true
    }
    
    // MARK: - Initialize
    
    func initialize() throws {
        try initializeLocale()
        initializeTime()
        try initializePresentation()
    }
    
    // MARK: - Presentation
    
    var presentation: PresentationProtocol!
    
    func initializePresentation() throws {
        let presentationAppearanceSetting: PresentationAppearanceSetting = .dark
        let presentationLocale = LocaleMapper.mapToPresentation(locale: locale)
        var presentation: PresentationProtocol = Presentation(locale: presentationLocale, time: time, appearanceSetting: presentationAppearanceSetting)
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
    
    private var _storeKitProvider: StoreKitProvider?
    var storeKitProvider: StoreKitProvider {
        if let storeKitProvider = _storeKitProvider {
            return storeKitProvider
        }
        let storeKitProvider = StoreKitProvider()
        _storeKitProvider = storeKitProvider
        return storeKitProvider
    }
}
