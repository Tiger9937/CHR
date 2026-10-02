import UIKit

class AppRouter {
    
    static var VC: UIViewController?
    
    static func callRoute(_ viewController: UIViewController) {
        VC = viewController
    }
    
    static func start() -> UIViewController {
        let mainVC = VC ?? ChatwindowVC()
        return UINavigationController(rootViewController: mainVC)
    }
    
    static func Navigate(from: UIViewController,
                         to: UIViewController,
                         isAnimated: Bool,
                         hideBackButton: Bool,
                         diraction: CATransitionSubtype
    ) {
        
        to.navigationItem.hidesBackButton = hideBackButton
        
        if isAnimated {
            let transition = CATransition()
            transition.duration = 0.20
            transition.type = .moveIn
            transition.subtype = diraction   // 👈 right → left
            
            from.navigationController?.view.layer.add(transition, forKey: kCATransition)
            
            to.navigationController?.view.layer.add(transition, forKey: kCATransition)
            
            from.navigationController?.pushViewController(to, animated: false)
        } else {
            from.navigationController?.pushViewController(to, animated: true)
        }
    }
}
 
//[weak self] _ in
//    guard let self = self else { return }
//    self.navigationController?.pushViewController(self.screenTWO, animated: true)
