//
//  JWST_UINavigationController++.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

public extension UINavigationController {
    
    func push(_ vc: UIViewController, type: JWStackTransitionType? = nil, duration: TimeInterval? = nil) {
        let transition = JWStackTransition(type: type, duration: duration)
        JWStackTransitionHijack.default.hook(transition, for: self)
        pushViewController(vc, animated: true)
    }
    
    func push(_ vc: UIViewController, transition: JWStackTransition) {
        JWStackTransitionHijack.default.hook(transition, for: self)
        pushViewController(vc, animated: true)
    }
    
}

public extension UINavigationController {
    
    func pop(_ type: JWStackTransitionType? = nil, duration: TimeInterval? = nil) {
        let transition = JWStackTransition(type: type, duration: duration)
        JWStackTransitionHijack.default.hook(transition, for: self)
        popViewController(animated: true)
    }
    
    func pop(_ transition: JWStackTransition) {
        JWStackTransitionHijack.default.hook(transition, for: self)
        popViewController(animated: true)
    }
    
}
