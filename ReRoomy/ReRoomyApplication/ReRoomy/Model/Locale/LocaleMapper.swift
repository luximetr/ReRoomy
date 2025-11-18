import ReRoomyPresentation

typealias PresentationLocale = ReRoomyPresentation.Locale

class LocaleMapper {
    
    // MARK: - Presentation
    
    static func mapToPresentation(locale: Locale) -> PresentationLocale {
        let presentationLanguage = LanguageMapper.mapToPresentation(locale.language)
        let presentationLocale = PresentationLocale(
            language: presentationLanguage,
            scriptCode: locale.scriptCode,
            regionCode: locale.regionCode
        )
        return presentationLocale
    }
    
}
