import Foundation

struct UnlimitedPlan: CustomDebugStringConvertible {
    let id: String
    let price: Decimal
    let currencyCode: String
    
    init(id: String, price: Decimal, currencyCode: String) {
        self.id = id
        self.price = price
        self.currencyCode = currencyCode
    }
    
    var debugDescription: String {
        return "PremiumSubscriptionPlan(id: \(String(reflecting: id)), price: \(String(reflecting: price)), currencyCode: \(String(reflecting: currencyCode)))"
    }
}
