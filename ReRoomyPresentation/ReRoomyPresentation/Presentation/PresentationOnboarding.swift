import UIKit

extension Presentation {
    
    public func showOnboarding() {
        let viewController = createOnboardingPaywallScreenViewController()
        self.window.rootViewController = viewController
        self.window.makeKeyAndVisible()
    }
    
    private func createOnboardingPaywallScreenViewController() -> OnboardingPaywallScreenViewController {
        let viewController = OnboardingPaywallScreenViewController(appearance: appearance, locale: locale, time: time)
        viewController.getUnlimitedPlans = { [weak self] completion in
            guard let self = self else { return }
            Task(priority: .userInitiated) {
                do {
                    let plans = try await getUnlimitedPlans()
                    completion(plans)
                } catch {
                    print("Handle error \(error.localizedDescription)")
                }
            }
        }
        viewController.onPurchaseUnlimitedPlan = { [weak self] plan in
            guard let self = self else { return }
            Task(priority: .userInitiated) {
                do {
                    let result = try await purchaseUnlimitedPlan(plan)
                    switch result {
                    case .pending:
                        print("Pending")
                    case .purchased:
                        print("Purchased")
                    case .userCancelled:
                        print("User cancelled")
                    case .unknown:
                        print("Uknown")
                    }
                } catch {
                    print("Handle error \(error.localizedDescription)")
                }
            }
        }
        return viewController
    }
}
