//
//  JWStackTransitionAnimationRotate.swift
//  Pods
//
//  Created by sfh on 2025/5/28.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationRotate: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationRotateType = .clockWise // animation rotate type
    private var angle: Double = 0.99 // animation rotate angle, (0.0, 1.0)
    
    public init(_ type: JWStackTransitionAnimationRotateType, rotateAngle: Double) {
        self.type = type
        if rotateAngle > 0.0 && rotateAngle <= 1.0 {
            self.angle = rotateAngle
        }
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
        
        let angle = self.type == .clockWise ? (self.angle * .pi) : -(self.angle * .pi)
        
        fromContainer.alpha = 1
        var transform = fromView.layer.transform
        transform = CATransform3DRotate(transform, angle, 0.0, 0.0, 1.0)
        
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
