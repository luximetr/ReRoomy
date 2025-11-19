import UIKit

struct DefaultAppearanceFonts: AppearanceFonts {
    
    func primary(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func primaryRounded(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontDescriptor = primary(size: size, weight: weight).fontDescriptor
        let roundedFontDescritor = fontDescriptor.withDesign(.rounded) ?? fontDescriptor
        return UIFont(descriptor: roundedFontDescritor, size: size)
    }
    
}
