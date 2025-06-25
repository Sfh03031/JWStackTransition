//
//  JWStackTransitionAnimationNatGeo.swift
//  Pods
//
//  Created by sfh on 2025/6/18.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationNatGeo: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationNatGeoType = .geoLeft // animation natGeo type
    
    public init(_ type: JWStackTransitionAnimationNatGeoType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        fromView.frame = transitionContext.finalFrame(for: toVC)
        toView.frame = transitionContext.finalFrame(for: toVC)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let fromLayer = fromView.layer
        let toLayer = toView.layer
        
        switch self.type {
        case .geoLeft:
            let oldFrame = fromLayer.frame
            fromLayer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            fromLayer.frame = oldFrame
            
            // fromLayer initial transform
            var transform = CATransform3DIdentity
            transform.m34 = -0.002
            transform = CATransform3DTranslate(transform, 0.0, 0.0, 0.0)
            fromLayer.transform = transform
            
            // toLayer initial transform
            var transform1 = CATransform3DIdentity
            transform1.m34 = -0.002
            transform1 = CATransform3DRotate(transform1, 1 / 36 * .pi, 0.0, 0.0, 1.0)
            transform1 = CATransform3DTranslate(transform1, 320.0, -40.0, 150.0)
            transform1 = CATransform3DRotate(transform1, -0.25 * .pi, 0.0, 1.0, 0.0)
            transform1 = CATransform3DRotate(transform1, 1 / 18 * .pi, 1.0, 0.0, 0.0)
            toLayer.transform = transform1
            
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeCubic) {
                // fromLayer final transform
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                    var transform = CATransform3DIdentity
                    transform.m34 = -0.002
                    transform = CATransform3DRotate(transform, 0.4 * .pi, 0.0, 1.0, 0.0)
                    transform = CATransform3DTranslate(transform, 0.0, 0.0, -20.0)
                    transform = CATransform3DTranslate(transform, 200.0, 0.0, 0.0)
                    fromLayer.transform = transform
                }
                // toLayer final transform
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    var transform = CATransform3DIdentity
                    transform.m34 = -0.002
                    transform = CATransform3DRotate(transform, 0.0, 0.0, 0.0, 1.0)
                    transform = CATransform3DTranslate(transform, 0.0, 0.0, 0.0)
                    transform = CATransform3DRotate(transform, 0.0, 0.0, 1.0, 0.0)
                    transform = CATransform3DRotate(transform, 0.0, 1.0, 0.0, 0.0)
                    toLayer.transform = transform
                }
            } completion: { finished in
                if finished {
                    fromView.layer.transform = CATransform3DIdentity
                    toView.layer.transform = CATransform3DIdentity
                    containerView.layer.transform = CATransform3DIdentity
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        case .geoRight:
            let oldFrame = fromLayer.frame
            fromLayer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
            fromLayer.frame = oldFrame
            
            // fromLayer initial transform
            var transform = CATransform3DIdentity
            transform.m34 = -0.002
            transform = CATransform3DTranslate(transform, 0.0, 0.0, 0.0)
            fromLayer.transform = transform
            
            // toLayer initial transform
            var transform1 = CATransform3DIdentity
            transform1.m34 = -0.002
            transform1 = CATransform3DRotate(transform1, 1 / 36 * .pi, 0.0, 0.0, 1.0)
            transform1 = CATransform3DTranslate(transform1, -320.0, 40.0, 150.0)
            transform1 = CATransform3DRotate(transform1, 0.25 * .pi, 0.0, 1.0, 0.0)
            transform1 = CATransform3DRotate(transform1, 1 / 18 * .pi, 1.0, 0.0, 0.0)
            toLayer.transform = transform1
            
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModeCubic) {
                // fromLayer final transform
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                    var transform = CATransform3DIdentity
                    transform.m34 = -0.002
                    transform = CATransform3DRotate(transform, -0.4 * .pi, 0.0, 1.0, 0.0)
                    transform = CATransform3DTranslate(transform, 0.0, 0.0, -20.0)
                    transform = CATransform3DTranslate(transform, -200.0, 0.0, 0.0)
                    fromLayer.transform = transform
                }
                // toLayer final transform
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    var transform = CATransform3DIdentity
                    transform.m34 = -0.002
                    transform = CATransform3DRotate(transform, 0.0, 0.0, 0.0, 1.0)
                    transform = CATransform3DTranslate(transform, 0.0, 0.0, 0.0)
                    transform = CATransform3DRotate(transform, 0.0, 0.0, 1.0, 0.0)
                    transform = CATransform3DRotate(transform, 0.0, 1.0, 0.0, 0.0)
                    toLayer.transform = transform
                }
            } completion: { finished in
                if finished {
                    fromView.layer.transform = CATransform3DIdentity
                    toView.layer.transform = CATransform3DIdentity
                    containerView.layer.transform = CATransform3DIdentity
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }

        }
    }
}

#endif
