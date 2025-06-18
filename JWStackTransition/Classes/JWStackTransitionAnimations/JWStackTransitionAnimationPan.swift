//
//  JWStackTransitionAnimationPan.swift
//  Pods
//
//  Created by sfh on 2025/6/18.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationPan: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationPanType = .panLeft // animation cube type
    
    public init(_ type: JWStackTransitionAnimationPanType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        fromView.frame = transitionContext.finalFrame(for: toVC)
        toView.frame = transitionContext.finalFrame(for: toVC)
        
        let fromOriginRect = fromView.frame
        let toOriginRect = toView.frame
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        switch self.type {
        case .panLeft:
            toView.frame = CGRectOffset(toView.frame, toView.frame.width, 0)
            
            UIView.animate(withDuration: duration) {
                fromView.frame = CGRectOffset(fromView.frame, -fromView.frame.width, 0)
                toView.frame = CGRectOffset(toView.frame, -toView.frame.width, 0)
            } completion: { _ in
                if transitionContext.transitionWasCancelled {
                    fromView.frame = fromOriginRect
                    toView.frame = toOriginRect
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .panRight:
            toView.frame = CGRectOffset(toView.frame, -toView.frame.width, 0)
            
            UIView.animate(withDuration: duration) {
                fromView.frame = CGRectOffset(fromView.frame, fromView.frame.width, 0)
                toView.frame = CGRectOffset(toView.frame, toView.frame.width, 0)
            } completion: { _ in
                if transitionContext.transitionWasCancelled {
                    fromView.frame = fromOriginRect
                    toView.frame = toOriginRect
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .panTop:
            toView.frame = CGRectOffset(toView.frame, 0, toView.frame.height)
            
            UIView.animate(withDuration: duration) {
                fromView.frame = CGRectOffset(fromView.frame, 0, -fromView.frame.height)
                toView.frame = CGRectOffset(toView.frame, 0, -toView.frame.height)
            } completion: { _ in
                if transitionContext.transitionWasCancelled {
                    fromView.frame = fromOriginRect
                    toView.frame = toOriginRect
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .panBottom:
            toView.frame = CGRectOffset(toView.frame, 0, -toView.frame.height)
            
            UIView.animate(withDuration: duration) {
                fromView.frame = CGRectOffset(fromView.frame, 0, fromView.frame.height)
                toView.frame = CGRectOffset(toView.frame, 0, toView.frame.height)
            } completion: { _ in
                if transitionContext.transitionWasCancelled {
                    fromView.frame = fromOriginRect
                    toView.frame = toOriginRect
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}


#endif
