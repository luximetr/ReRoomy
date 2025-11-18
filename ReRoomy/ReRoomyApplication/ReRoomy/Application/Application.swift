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
//        calendar.locale = locale.foundationLocale
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
//        do {
//            let storageSelectedLanguage = try storage.getSelectedLanguage()
//            let selectedLanguage = LanguageMapper.mapToLanguage(storageSelectedLanguage)
//            let deviceLanguage = LanguageMapper.mapToLanguage(devicePreferredLanguages)
//            let language = selectedLanguage ?? deviceLanguage ?? .english
//            let locale = Locale(language: language)
            self.locale = Locale.current
//        } catch {
//            throw Error("Cannot initialize locale\n\(error)")
//        }
    }
}
