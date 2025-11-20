import ReRoomyPresentation

typealias PresentationUnlimitedPlanPurchaseResult = ReRoomyPresentation.UnlimitedPlanPurchaseResult

class UnlimitedPlanPurchaseResultMapper {
    
    static func mapToPresentation(_ result: UnlimitedPlanPurchaseResult) -> PresentationUnlimitedPlanPurchaseResult {
        switch result {
            case .purchased:
        return .purchased
        case .pending:
            return .pending
        case .userCancelled:
            return .userCancelled
        case .unknown:
            return .unknown
        }
    }
}
