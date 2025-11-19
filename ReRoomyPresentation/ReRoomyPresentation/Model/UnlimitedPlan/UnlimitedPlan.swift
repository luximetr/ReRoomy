import Foundation

public struct UnlimitedPlan {
    public let id: String
    public let price: Decimal
    public let priceFormatted: String
    public let currencyCode: String
    
    public init(id: String, price: Decimal, priceFormatted: String, currencyCode: String) {
        self.id = id
        self.price = price
        self.priceFormatted = priceFormatted
        self.currencyCode = currencyCode
    }
}
