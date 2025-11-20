protocol StoreKitProviderProtocol {
    func requestUnlimitedPlans() async throws -> UnlimitedPlans
    func purchase(plan: UnlimitedPlan) async throws -> UnlimitedPlanPurchaseResult
}
