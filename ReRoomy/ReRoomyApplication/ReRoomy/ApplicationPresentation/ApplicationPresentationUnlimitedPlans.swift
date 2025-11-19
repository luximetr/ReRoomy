import Foundation

extension Application {
    
    func presentationUnlimitedPlans() async throws -> PresentationUnlimitedPlans {
        let plans = try await storeKitProvider.requestUnlimitedPlans()
        let presentationUnlimitedPlans = UnlimitedPlansMapper.mapToPresentation(plans)
        return presentationUnlimitedPlans
    }
}
