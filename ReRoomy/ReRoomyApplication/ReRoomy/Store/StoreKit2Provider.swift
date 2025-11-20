import StoreKit
import Foundation
import UIKit

@available(iOS 15, *)
class StoreKit2Provider: StoreKitProviderProtocol {
    
    // MARK: - Init
    
    init() {
        updatesListener = createUpdatesListener()
    }
    
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
    
    private func parsePlans(products: [Product]) throws -> UnlimitedPlans {
        let yearlyPlan = try parseUnlimitedPlan(products: products, productId: yearlyPlanProductId)
        let weeklyPlan = try parseUnlimitedPlan(products: products, productId: weeklyPlanProductId)
        return .init(yearly: yearlyPlan, weekly: weeklyPlan)
    }
    
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
        let price = try parsePrice(from: offer)
        guard let currencyCode = offer["currencyCode"] as? String else {
            throw Error.failedToParseProductCurrencyCode
        }
        
        return .init(
            id: productId,
            price: price,
            currencyCode: currencyCode
        )
    }
    
    private func parsePrice(from offer: [String: Any]) throws -> Decimal {
        let priceValue = offer["priceString"] ?? offer["price"]
        if let priceString = priceValue as? String, let price = Decimal(string: priceString) {
            return price
        }
        if let priceDouble = priceValue as? Double {
            return Decimal(priceDouble)
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
    private var updatesListener: Task<Void, Never>?
    
    func createUpdatesListener() -> Task<Void, Never> {
        Task(priority: .background) {
            for await verificationResult in Transaction.updates {
                handle(updatedTransaction: verificationResult)
            }
        }
    }
    
    private func handle(updatedTransaction verificationResult: VerificationResult<Transaction>) {
        guard case .verified(let transaction) = verificationResult else {
            return
        }
        if let expirationDate = transaction.expirationDate, expirationDate < Date() {
            return
        }
        if transaction.revocationDate != nil {
            removePurchasedProduct(transaction: transaction)
        } else {
            insertPurchasedProduct(transaction: transaction)
        }
    }
    
    private func insertPurchasedProduct(transaction: Transaction) {
    }
    
    private func removePurchasedProduct(transaction: Transaction) {
    }
    
    // MARK: - Restore purchase
    
    func restorePurchases() async throws {
        try await AppStore.sync()
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

