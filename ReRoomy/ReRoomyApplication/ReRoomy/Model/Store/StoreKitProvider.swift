import StoreKit
import Foundation
import UIKit

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
            yearly: .init(id: yearlyPlanProductId, price: 49.99, priceFormatted: "$49.99", currencyCode: "USD"),
            weekly: .init(id: weeklyPlanProductId, price: 7.99, priceFormatted: "$7.99", currencyCode: "USD")
        )
        if #available(iOS 15.0, *) {
            let products = try await Product.products(for: productIds)
            print(products)
        } else {
            // before iOS 15 implementation
        }
        return plans
    }
    
    // MARK: - Purchase
    
    func purchase(plan: UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult {
        if #available(iOS 15.0, *) {
            return try await purchaseStoreKit2(plan: plan)
        } else {
            // before iOS 15 implementation
            return .unknown
        }
    }
    
    @available(iOS 15, *)
    private func purchaseStoreKit2(plan: UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult {
        let products = try await Product.products(for: [plan.id])
        guard let product = products.first else {
            throw Error.productNotFound
        }
        let result = try await product.purchase()
        switch result {
        case .success(.verified(let transaction)):
            await transaction.finish()
            insertPurchasedProduct(transaction: transaction)
            return .purchased
        case .success(.unverified(_, let error)):
            throw error
        case .pending:
            return .pending
        case .userCancelled:
            return .userCancelled
        @unknown default:
            return .unknown
        }
    }
    
    // MARK: - Purchased
    
    private var purchasedProductIds: Set<String> = []
    
    @available(iOS 15, *)
    private func insertPurchasedProduct(transaction: Transaction) {
    }
    
    @available(iOS 15, *)
    private func removePurchasedProduct(transaction: Transaction) {
    }
    
    // MARK: - Error
    
    enum Error: Swift.Error {
        case productNotFound
    }
}

