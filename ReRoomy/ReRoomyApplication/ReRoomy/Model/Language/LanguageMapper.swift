import Foundation
import ReRoomyPresentation

typealias PresentationLanguage = ReRoomyPresentation.Language

class LanguageMapper {
    
    // MARK: - Presentation
    
    static func mapToPresentation(_ language: Language) -> PresentationLanguage {
        switch language {
        case .english: return .english
        }
    }
    
}
