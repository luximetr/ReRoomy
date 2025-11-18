import Foundation

struct Locale {
    
    let language: Language
    var scriptCode: String? { foundationLocale.scriptCode }
    var regionCode: String? { foundationLocale.regionCode }
    let foundationLocale: Foundation.Locale
    
    init(language: Language, foundationLocale: Foundation.Locale = .current) {
        self.language = language
        self.foundationLocale = Locale.makeFoundationLocale(language: language, foundationLocale: foundationLocale)
    }
    
    private static func makeFoundationLocale(language: Language, foundationLocale: Foundation.Locale) -> Foundation.Locale {
        let identifier = makeFoundationLocaleIdentifier(language: language, foundationLocale: foundationLocale)
        return Foundation.Locale(identifier: identifier)
    }
    
    private static func makeFoundationLocaleIdentifier(language: Language, foundationLocale: Foundation.Locale) -> String {
        let languageCode = LanguageCodeProvider.getCode(language: language)
        var identifier = languageCode
        if let scriptCode = foundationLocale.scriptCode {
            identifier += "-" + scriptCode
        }
        if let regionCode = foundationLocale.regionCode {
            identifier += "_" + regionCode
        }
        return identifier
    }
    
}
