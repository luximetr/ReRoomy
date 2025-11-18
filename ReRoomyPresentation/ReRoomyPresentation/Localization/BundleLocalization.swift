import Foundation

private class Class { }

extension Bundle {
    
    @MainActor class func forLocale(_ locale: Locale) -> Bundle? {
        let language = locale.language
        let languageCode: String
        switch language {
        case .english: languageCode = "en"
        }
        let bundle = localizedFor(language: languageCode, region: nil)
        return bundle
    }
    
    @MainActor private static var localizedBundles: [String: Bundle] = [:]
    
    @MainActor private class func localizedFor(language: String, region: String?) -> Bundle? {
        var resource = language
        if let region = region {
            resource += "_\(region)"
        }
        if let bundle = localizedBundles[resource] {
            return bundle
        } else {
            let resource = language
            let type = "lproj"
            if let path = Bundle.module.path(forResource: resource, ofType: type) {
                let bundle = Bundle(path: path)
                localizedBundles[resource] = bundle
                return bundle
            } else {
                return nil
            }
        }
    }
    
}
