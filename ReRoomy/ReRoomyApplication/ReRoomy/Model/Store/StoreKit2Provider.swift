import StoreKit
import Foundation
import UIKit

@available(iOS 15, *)
class StoreKit2Provider: NSObject, StoreKitProviderProtocol {
    
    // MARK: - Plans
    
    func requestUnlimitedPlans() async throws -> UnlimitedPlans {
        let productIds = [weeklyPlanProductId, yearlyPlanProductId]
        let products = try await Product.products(for: productIds)
        let plans = try parsePlans(products: products)
        return plans
    }
    
    // MARK: - Products
    
    private var weeklyPlanProductId: String { "com.sync.luximetr.reroomy.subscription.unlimited.weekly_v1" }
    private var yearlyPlanProductId: String { "com.sync.luximetr.reroomy.subscription.unlimited.yearly_v1" }
    
    private var products: [SKProduct] = []
    private var productsRequest: SKProductsRequest?
    
    @available(iOS 15, *)
    private func parsePlans(products: [Product]) throws -> UnlimitedPlans {
        let yearlyPlan = try parseUnlimitedPlan(products: products, productId: yearlyPlanProductId)
        let weeklyPlan = try parseUnlimitedPlan(products: products, productId: weeklyPlanProductId)
        return .init(yearly: yearlyPlan, weekly: weeklyPlan)
    }
    
    @available(iOS 15, *)
    private func parseUnlimitedPlan(products: [Product], productId: String) throws -> UnlimitedPlan {
        guard let product = products.first(where: { $0.id == productId }) else {
            throw Error.productNotFound
        }
        guard let productJSON = try JSONSerialization.jsonObject(with: product.jsonRepresentation) as? [String: Any] else {
            throw Error.failedToParseProductJSON
        }
        guard let productAttributes = productJSON["attributes"] as? [String: Any] else {
            throw Error.failedToParseProductAttributes
        }
        guard let offers = productAttributes["offers"] as? [[String: Any]], let offer = offers.first else {
            throw Error.failedToParseProductOffer
        }
        let (priceRaw, price) = try parsePrice(from: offer)
        guard let currencyCode = offer["currencyCode"] as? String else {
            throw Error.failedToParseProductCurrencyCode
        }
        
        return .init(
            id: productId,
            price: price,
            priceFormatted: priceRaw,
            currencyCode: currencyCode
        )
    }
    
    private func parsePrice(from offer: [String: Any]) throws -> (String, Decimal) {
        let priceValue = offer["priceString"] ?? offer["price"]
        if let priceString = priceValue as? String, let price = Decimal(string: priceString) {
            return (priceString, price)
        }
        if let priceDouble = priceValue as? Double {
            return (String(priceDouble), Decimal(priceDouble))
        }
        throw Error.failedToParseProductPrice
    }
    
    // MARK: - Purchase
    
    func purchase(plan: UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult {
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
        case failedToParseProductJSON
        case failedToParseProductAttributes
        case failedToParseProductOffer
        case failedToParseProductPrice
        case failedToParseProductCurrencyCode
    }
}

