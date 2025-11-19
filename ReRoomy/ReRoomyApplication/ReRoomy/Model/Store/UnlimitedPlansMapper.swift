import Foundation
import ReRoomyPresentation

typealias PresentationUnlimitedPlans = ReRoomyPresentation.UnlimitedPlans
typealias PresentationUnlimitedPlan = ReRoomyPresentation.UnlimitedPlan

class UnlimitedPlansMapper {
    
    static func mapToPresentation(_ plans: UnlimitedPlans) -> PresentationUnlimitedPlans {
        let yearly = mapToPresentation(plans.yearly)
        let weekly = mapToPresentation(plans.weekly)
        return .init(
            yearly: yearly,
            weekly: weekly
        )
    }
    
    private static func mapToPresentation(_ plan: UnlimitedPlan) -> PresentationUnlimitedPlan {
        return .init(
            id: plan.id,
            price: plan.price,
            priceFormatted: plan.priceFormatted,
            currencyCode: plan.currencyCode
        )
    }
}
