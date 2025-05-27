//
//  JWStackTransitionAnimationSwing.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationSwing: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationRectEdge = .top
    
    public init(_ edge: JWStackTransitionAnimationRectEdge) {
        self.type = edge
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.view)
        
        let fromW = fromVC.view.frame.width
        let fromH = fromVC.view.frame.height
        
        let toContainerView = UIView()
        toContainerView.backgroundColor = UIColor.clear
        toContainerView.frame = toVC.view.bounds
        
        switch self.type {
        case .left:
            toContainerView.frame.origin = CGPoint.init(x: -fromW, y: 0)
        case .right:
            toContainerView.frame.origin = CGPoint.init(x: fromW * 2, y: 0)
        case .top:
            toContainerView.frame.origin = CGPoint.init(x: 0, y: -fromH)
        case .bottom:
            toContainerView.frame.origin = CGPoint.init(x: 0, y: 2 * fromH)
        }
        
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
