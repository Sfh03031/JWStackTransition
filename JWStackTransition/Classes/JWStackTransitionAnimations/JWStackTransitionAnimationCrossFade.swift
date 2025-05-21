//
//  JWStackTransitionAnimationCrossFade.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationCrossFade: JWStackTransitionAnimationDelegate {
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        
        fromVC.view.alpha = 1.0
        toVC.view.alpha = 0.0
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.alpha = 0.0
            toVC.view.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.alpha = 1.0
        }
    }
    
}

#endif
