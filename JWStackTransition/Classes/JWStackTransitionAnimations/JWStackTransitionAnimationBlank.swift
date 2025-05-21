//
//  JWStackTransitionAnimationBlank.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationBlank: JWStackTransitionAnimationDelegate {
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(toVC.view)
        
    }
    
}

#endif
