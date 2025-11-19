import StoreKit
import Foundation

class StoreKitProvider: NSObject {
    
    // MARK: - Product ids
    
    private var weeklyPlanProductId: String { "com.sync.luximetr.reroomy.subscription.unlimited.weekly_v1" }
    private var yearlyPlanProductId: String { "com.sync.luximetr.reroomy.subscription.unlimited.yearly_v1" }
    
    // MARK: - Products
    
    private var products: [SKProduct] = []
    private var productsRequest: SKProductsRequest?
    
    // MARK: - Plans
    
    func requestUnlimitedPlans() async throws -> UnlimitedPlans {
        let productIds = [weeklyPlanProductId, yearlyPlanProductId]
        let plans = UnlimitedPlans(
            yearly: .init(id: "yearlyPlanId", price: 49.99, priceFormatted: "$49.99", currencyCode: "USD"),
            weekly: .init(id: "weeklyPlanId", price: 7.99, priceFormatted: "$7.99", currencyCode: "USD")
        )
        if #available(iOS 15.0, *) {
            let products = try await Product.products(for: productIds)
            print(products)
        } else {
            
        }
        return plans
    }
    
    // MARK: - Purchased
    
    private var purchasedProductIds: Set<String> = []
    
    enum UnlimitedPlanStatus {
        
    }
}

