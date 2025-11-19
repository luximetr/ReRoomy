import Foundation

public struct UnlimitedPlans {
    public let yearly: UnlimitedPlan
    public let weekly: UnlimitedPlan
    
    public init(yearly: UnlimitedPlan, weekly: UnlimitedPlan) {
        self.yearly = yearly
        self.weekly = weekly
    }
}
