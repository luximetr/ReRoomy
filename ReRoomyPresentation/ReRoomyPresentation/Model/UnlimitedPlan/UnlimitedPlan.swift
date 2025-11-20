import Foundation

public struct UnlimitedPlan {
    public let id: String
    public let price: Decimal
    public let currencyCode: String
    
    public init(id: String, price: Decimal, currencyCode: String) {
        self.id = id
        self.price = price
        self.currencyCode = currencyCode
    }
}
