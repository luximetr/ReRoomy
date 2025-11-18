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
        let presentation: PresentationProtocol = Presentation()
        self.presentation = presentation
    }
}
