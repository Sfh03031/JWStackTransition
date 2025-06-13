//
//  JWStackTransitionHijack.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

import UIKit

class JWStackTransitionHijack: NSObject {
    
    static let `default` = JWStackTransitionHijack()
    
    var transitions: [JWStackTransition] = []
    var oldNavDelegate: UINavigationControllerDelegate?
    
    func hook(_ transition: JWStackTransition, for nav: UINavigationController) {
        
        transitions.append(transition)
        
        oldNavDelegate = nav.delegate
        
        nav.delegate = JWStackTransitionHijack.default
    }
}

extension JWStackTransitionHijack: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        let transition = transitions.popLast()
        
        navigationController.delegate = oldNavDelegate
        
        return transition
    }
}
