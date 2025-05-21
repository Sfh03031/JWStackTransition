//
//  JWStackTransitionAnimationFlip.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationFlip: JWStackTransitionAnimationDelegate {
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.view)
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut]
        
        UIView.transition(with: containerView, duration: duration, options: transitionOptions, animations: {
            containerView.addSubview(toVC.view)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}

#endif
