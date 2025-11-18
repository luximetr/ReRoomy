import Foundation

class LanguageCodeProvider {
    
    static func getCode(language: Language) -> String {
        switch language {
        case .english: return "en"
        }
    }
}
