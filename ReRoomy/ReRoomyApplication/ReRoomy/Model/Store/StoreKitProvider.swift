import Foundation

class StoreKitProvider: StoreKitProviderProtocol {
    func requestUnlimitedPlans() async throws -> UnlimitedPlans {
        let plans = UnlimitedPlans(
            yearly: .init(id: "yearlyPlanProductId", price: 49.99, priceFormatted: "$49.99", currencyCode: "USD"),
            weekly: .init(id: "weeklyPlanProductId", price: 7.99, priceFormatted: "$7.99", currencyCode: "USD")
        )
        return plans
    }
    
    func purchase(plan: UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult {
        return .unknown
    }
}
