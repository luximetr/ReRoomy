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
        return viewController
    }
}
