import UIKit
import ReRoomyPresentation

class Application: NSObject, UIApplicationDelegate {
    
    // MARK: - Life cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            try initialize()
            presentation.show()
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
        let presentationAppearanceSetting: PresentationAppearanceSetting = .light
        let presentation: PresentationProtocol = Presentation(locale: locale, time: time, appearanceSetting: presentationAppearanceSetting)
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
        self.locale = Locale.current
    }
}
