//
//  JWStackTransitionAnimationRotate.swift
//  Pods
//
//  Created by sfh on 2025/5/28.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationRotate: JWStackTransitionAnimationDelegate {
    
    fileprivate var stepDistance : CGFloat = 0.25
    fileprivate var animationStepTime : TimeInterval = 0.2
    
    public init(distance: CGFloat = 0.333, time: TimeInterval = 0.333) {
        self.stepDistance = distance
        self.animationStepTime = time
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let fromContainer = UIView()
        fromContainer.frame = fromView.bounds
        containerView.addSubview(fromContainer)
        
        fromContainer.addSubview(fromView)
        
        fromContainer.alpha = 1
        var transform = fromView.layer.transform
        transform = CATransform3DRotate(transform, .pi, 0.0, 0.0, 1.0)
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear]) {
            fromContainer.alpha = 0
            fromView.layer.transform = transform
        } completion: { finished in
            if finished {
                fromView.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
}

#endif
