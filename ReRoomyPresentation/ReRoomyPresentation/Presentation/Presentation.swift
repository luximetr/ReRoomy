import UIKit

@MainActor
public final class Presentation: @MainActor PresentationProtocol {
    
    // MARK: - Init
    
    public init() {
        let window = UIWindow()
        window.windowLevel = .normal
        self.window = window
    }
    
    // MARK: - Windows
    
    let window: UIWindow
    
    // MARK: - Display
    
    public func show() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
