//
//  JWStackTransitionAnimationPan.swift
//  Pods
//
//  Created by sfh on 2025/6/18.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationPan: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationPanType = .panLeft // animation pan type
    private var shake: Bool = false // whether toView shake or not
    
    public init(_ type: JWStackTransitionAnimationPanType) {
        self.type = type
        if type == .panTopWithShake || type == .panBottomWithShake || type == .panLeftWithShake || type == .panRightWithShake {
            self.shake = true
        }
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
        
        var fromFinalFrame = CGRect.zero
        var toFinalFrame = CGRect.zero
        
        switch self.type {
        case .panLeft, .panLeftWithShake:
            toView.frame = CGRectOffset(toView.frame, toView.frame.width, 0)
            
            fromFinalFrame = CGRectOffset(fromView.frame, -fromView.frame.width, 0)
            toFinalFrame = CGRectOffset(toView.frame, -toView.frame.width, 0)
        case .panRight, .panRightWithShake:
            toView.frame = CGRectOffset(toView.frame, -toView.frame.width, 0)
            
            fromFinalFrame = CGRectOffset(fromView.frame, fromView.frame.width, 0)
            toFinalFrame = CGRectOffset(toView.frame, toView.frame.width, 0)
        case .panTop, .panTopWithShake:
            toView.frame = CGRectOffset(toView.frame, 0, toView.frame.height)
            
            fromFinalFrame = CGRectOffset(fromView.frame, 0, -fromView.frame.height)
            toFinalFrame = CGRectOffset(toView.frame, 0, -toView.frame.height)
        case .panBottom, .panBottomWithShake:
            toView.frame = CGRectOffset(toView.frame, 0, -toView.frame.height)
            
            fromFinalFrame = CGRectOffset(fromView.frame, 0, fromView.frame.height)
            toFinalFrame = CGRectOffset(toView.frame, 0, toView.frame.height)
        }
        
        UIView.animate(withDuration: duration) {
            fromView.frame = fromFinalFrame
            toView.frame = toFinalFrame
            
            if self.shake {
                UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeLinear) {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                        toView.transform = CGAffineTransform.init(rotationAngle: 0.2)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                        toView.transform = CGAffineTransform.init(rotationAngle: -0.2)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                        toView.transform = CGAffineTransform.init(rotationAngle: 0.2)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                        toView.transform = CGAffineTransform.init(rotationAngle: -0.2)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                        toView.transform = CGAffineTransform.init(rotationAngle: 0.0)
                    }
                }
            }
        } completion: { finished in
            if finished {
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
