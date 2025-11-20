import Foundation
import StoreKit

class StoreKitProvider: NSObject, StoreKitProviderProtocol, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    // MARK: - Init
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    @MainActor
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    // MARK: - Plans
    
    func requestUnlimitedPlans() async throws -> UnlimitedPlans {
        let productIds = [weeklyPlanProductId, yearlyPlanProductId]
        let products = try await requestProducts(productIds: Set(productIds))
        let plans = try parsePlans(products: products)
        return plans
    }
    
    // MARK: - Products
    
    private var weeklyPlanProductId: String { "com.sync.luximetr.reroomy.subscription.unlimited.weekly_v1" }
    private var yearlyPlanProductId: String { "com.sync.luximetr.reroomy.subscription.unlimited.yearly_v1" }
    
    private var productRequestContinuation: CheckedContinuation<[SKProduct], Swift.Error>?
    
    private func requestProducts(productIds: Set<String>) async throws -> [SKProduct] {
        try await withCheckedThrowingContinuation { continuation in
            self.productRequestContinuation = continuation
            let request = SKProductsRequest(productIdentifiers: productIds)
            request.delegate = self
            request.start()
        }
    }
    
    private func parsePlans(products: [SKProduct]) throws -> UnlimitedPlans {
        let yearlyPlan = try parseUnlimitedPlan(products: products, productId: yearlyPlanProductId)
        let weeklyPlan = try parseUnlimitedPlan(products: products, productId: weeklyPlanProductId)
        return .init(yearly: yearlyPlan, weekly: weeklyPlan)
    }
    
    private func parseUnlimitedPlan(products: [SKProduct], productId: String) throws -> UnlimitedPlan {
        guard let product = products.first(where: { $0.productIdentifier == productId }) else {
            throw Error.productNotFound
        }
        
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = product.priceLocale
        let priceFormatted = priceFormatter.string(from: product.price) ?? "\(product.price)"
        let currencyCode = product.priceLocale.currencyCode ?? "USD"
        
        return .init(
            id: productId,
            price: product.price as Decimal,
            priceFormatted: priceFormatted,
            currencyCode: currencyCode
        )
    }
    
    // MARK: - Purchase
    
    private var purchaseContinuation: CheckedContinuation<UnlimitedPlanPurchaseResult, Swift.Error>?
    private var currentPurchaseProductId: String?
    
    func purchase(plan: UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult {
        let productIds = Set([plan.id])
        let products = try await requestProducts(productIds: productIds)
        
        guard let product = products.first else {
            throw Error.productNotFound
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            self.purchaseContinuation = continuation
            self.currentPurchaseProductId = plan.id
            
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    // MARK: - Restore purchase
    
    func restorePurchases() async throws {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - SKPaymentTransactionObserver
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            guard transaction.payment.productIdentifier == currentPurchaseProductId else {
                continue
            }
            
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                purchaseContinuation?.resume(returning: .purchased)
                purchaseContinuation = nil
                currentPurchaseProductId = nil
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                if let error = transaction.error as? SKError {
                    if error.code == .paymentCancelled {
                        purchaseContinuation?.resume(returning: .userCancelled)
                    } else {
                        purchaseContinuation?.resume(throwing: error)
                    }
                } else {
                    purchaseContinuation?.resume(throwing: Error.purchaseFailed)
                }
                purchaseContinuation = nil
                currentPurchaseProductId = nil
                
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                purchaseContinuation?.resume(returning: .purchased)
                purchaseContinuation = nil
                currentPurchaseProductId = nil
                
            case .deferred:
                purchaseContinuation?.resume(returning: .pending)
                purchaseContinuation = nil
                currentPurchaseProductId = nil
                
            case .purchasing:
                break
                
            @unknown default:
                break
            }
        }
    }
    
    // MARK: - SKProductsRequestDelegate

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productRequestContinuation?.resume(returning: response.products)
        productRequestContinuation = nil
    }
    
    func request(_ request: SKRequest, didFailWithError error: Swift.Error) {
        productRequestContinuation?.resume(throwing: error)
        productRequestContinuation = nil
    }
    
    // MARK: - Error
    
    enum Error: Swift.Error {
        case productNotFound
        case productRequestFailed
        case purchaseFailed
    }
}
