//
//  JWStackTransitionAnimationRoll.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationRoll: JWStackTransitionAnimationDelegate {
    
    fileprivate var step: CGFloat = 0.125 // scale step
    fileprivate var axis: JWStackTransitionAnimationRollAxis = .y // rotate animation axis
    
    public init(_ axis: JWStackTransitionAnimationRollAxis) {
        self.axis = axis
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let tempView = UIView()
        tempView.frame = fromView.bounds
        tempView.addSubview(fromView)
        containerView.addSubview(tempView)
        
        toRoll(tempView, scale: 1.0 - self.step, transitionContext: transitionContext)
    }
    
}

extension JWStackTransitionAnimationRoll {
    
    /// roll animation
    /// - Parameters:
    ///   - rollView: roll view
    ///   - scale: transform scale
    ///   - complete: animation finished call back
    func toRoll(_ rollView: UIView, scale: CGFloat, transitionContext: UIViewControllerContextTransitioning) {
        var transform = rollView.layer.transform
        rollView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        
        let rotateX = self.axis == .x ? 1.0 : 0.0
        let rotateY = self.axis == .y ? 1.0 : 0.0
        let rotateZ = self.axis == .z ? 1.0 : 0.0
        transform = CATransform3DRotate(transform, .pi, rotateX, rotateY, rotateZ)
        transform = CATransform3DScale(transform, scale, scale, 1.0)
        
        let next = scale - self.step
        
        UIView.animate(withDuration: TimeInterval(0.125), delay: 0, options: [.curveLinear]) {
            rollView.layer.transform = transform
            rollView.alpha = scale
        } completion: { finished in
            if finished {
                DispatchQueue.main.async {
                    if next > 0 {
                        self.toRoll(rollView, scale: next, transitionContext: transitionContext)
                    } else {
                        rollView.layer.transform = CATransform3DIdentity
                        rollView.removeFromSuperview()
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    }
                }
            }
            
        }
        
    }
}

#endif
