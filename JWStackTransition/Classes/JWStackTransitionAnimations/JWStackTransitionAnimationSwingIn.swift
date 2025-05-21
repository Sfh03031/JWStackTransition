//
//  JWStackTransitionAnimationSwingIn.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationSwingIn: JWStackTransitionAnimationDelegate {
    
    private var isLeft: Bool = true
    
    public init(isLeft: Bool) {
        self.isLeft = isLeft
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.view)
        
        let toContainerView = UIView()
        toContainerView.backgroundColor = UIColor.clear
        toContainerView.frame = toVC.view.bounds
        toContainerView.frame.origin = CGPoint.init(x: isLeft ? -fromVC.view.bounds.width : fromVC.view.bounds.width * 2, y: 0)
        
        toContainerView.addSubview(toVC.view)
        containerView.addSubview(toContainerView)
        
        toVC.view.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
            toVC.view.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [.curveEaseInOut], animations: {
            toContainerView.frame = fromVC.view.bounds
        }, completion: nil)
    }
    
}

#endif
