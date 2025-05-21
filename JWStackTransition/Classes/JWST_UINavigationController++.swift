//
//  JWST_UINavigationController++.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

public extension UINavigationController {
    
    func push(_ vc: UIViewController, withType type: JWStackTransitionType, withDuration duration: TimeInterval) {
        let transition = JWStackTransition(type: type, duration: duration)
        JWStackTransitionHijack.default.hook(transition, for: self)
        pushViewController(vc, animated: true)
    }
    
    func push(_ vc: UIViewController, with transition: JWStackTransition) {
        JWStackTransitionHijack.default.hook(transition, for: self)
        pushViewController(vc, animated: true)
    }
    
    func popViewControllerRetroTransition(_ transition: JWStackTransition) {
        JWStackTransitionHijack.default.hook(transition, for: self)
        popViewController(animated: true)
    }
    
}
