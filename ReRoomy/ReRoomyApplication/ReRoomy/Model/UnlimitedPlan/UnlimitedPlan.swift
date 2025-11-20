import Foundation

struct UnlimitedPlan: CustomDebugStringConvertible {
    let id: String
    let price: Decimal
    let priceFormatted: String
    let currencyCode: String
    
    init(id: String, price: Decimal, priceFormatted: String, currencyCode: String) {
        self.id = id
        self.price = price
        self.priceFormatted = priceFormatted
        self.currencyCode = currencyCode
    }
    
    var debugDescription: String {
        return "PremiumSubscriptionPlan(id: \(String(reflecting: id)), price: \(String(reflecting: price)), priceFormatted: \(String(reflecting: priceFormatted)), currencyCode: \(String(reflecting: currencyCode)))"
    }
}
