import Foundation

struct UnlimitedPlans {
    let yearly: UnlimitedPlan
    let weekly: UnlimitedPlan
    
    init(yearly: UnlimitedPlan, weekly: UnlimitedPlan) {
        self.yearly = yearly
        self.weekly = weekly
    }
}
