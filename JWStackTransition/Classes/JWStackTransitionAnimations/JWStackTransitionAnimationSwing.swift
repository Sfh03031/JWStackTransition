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
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        
        let fromW = fromView.frame.width
        let fromH = fromView.frame.height
        
        let toContainerView = UIView()
        toContainerView.backgroundColor = .clear
        toContainerView.frame = toView.bounds
        
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
        
        toContainerView.addSubview(toView)
        containerView.addSubview(toContainerView)
        
        toView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
            toView.transform = CGAffineTransform.identity
        }) { finished in
            if finished {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [.curveEaseInOut], animations: {
            toContainerView.frame = fromView.bounds
        }, completion: nil)
        
    }
    
}

#endif
