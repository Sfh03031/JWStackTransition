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
        
        print("stepDistance: \(stepDistance)")
        print("animationStepTime: \(animationStepTime)")
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        let fromContainer = UIView()
        fromContainer.frame = fromVC.view.bounds
        containerView.addSubview(fromContainer)
        
        fromContainer.addSubview(fromVC.view)
        
//        flipTo(transitionContext: transitionContext, view: fromVC.view, scale: 1.0 - stepDistance)
        
        
        
        fromContainer.alpha = 1
        var transform = fromVC.view.layer.transform
        transform = CATransform3DRotate(transform, .pi, 0.0, 0.0, 1.0)
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear]) {
            fromContainer.alpha = 0
            fromVC.view.layer.transform = transform
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.layer.transform = CATransform3DIdentity
        }


    }
    
    private func flipTo(transitionContext: UIViewControllerContextTransitioning, view: UIView, scale: CGFloat) {
        var transform = view.layer.transform
//        view.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        
        transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0.0, 0.0, 1.0)
        transform = CATransform3DScale(transform, scale, scale, 1.0)
        
        let nextScale = scale - stepDistance
        
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: [.transitionCurlUp, .curveEaseInOut]) {
            view.layer.transform = transform
        }
        
        JWStackTransition.delay(second: self.animationStepTime) {
            if nextScale > 0 {
                self.flipTo(transitionContext: transitionContext, view: view, scale: nextScale)
            } else {
                transitionContext.completeTransition(true)
                view.layer.transform = CATransform3DIdentity
            }
        }
        
        
    }
    
}

#endif
