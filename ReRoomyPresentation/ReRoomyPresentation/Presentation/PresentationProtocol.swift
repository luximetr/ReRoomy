public protocol PresentationProtocol {
    func showOnboarding()
    var getUnlimitedPlans: (() async throws -> UnlimitedPlans)! { set get }
    var purchaseUnlimitedPlan: ((UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult)! { set get }
}
