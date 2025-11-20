import Foundation

extension Application {
    
    func presentationUnlimitedPlans() async throws -> PresentationUnlimitedPlans {
        let plans = try await storeKitProvider.requestUnlimitedPlans()
        let presentationUnlimitedPlans = UnlimitedPlansMapper.mapToPresentation(plans)
        return presentationUnlimitedPlans
    }
    
    func presentationPurchaseUnlimitedPlan(_ presentationPlan: PresentationUnlimitedPlan) async throws -> PresentationUnlimitedPlanPurchaseResult {
        let plan = UnlimitedPlansMapper.mapToApplication(presentationPlan)
        let result = try await storeKitProvider.purchase(plan: plan)
        let presentationResult = UnlimitedPlanPurchaseResultMapper.mapToPresentation(result)
        return presentationResult
    }
}
