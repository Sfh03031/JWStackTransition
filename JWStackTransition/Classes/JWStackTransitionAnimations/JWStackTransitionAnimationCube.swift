//
//  JWStackTransitionAnimationCube.swift
//  Pods
//
//  Created by sfh on 2025/6/17.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationCube: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationCubeType = .fromLeftToRight // animation cube type
    private var perspective: CGFloat = -0.005 // perspective
    private var rotationAngle: Double = 0.5 * .pi // rotation angle
    
    public init(_ type: JWStackTransitionAnimationCubeType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }

        toView.frame = transitionContext.finalFrame(for: toVC)
        
        var viewFromTransform = CATransform3DIdentity
        var viewToTransform = CATransform3DIdentity
        
        let containerView = transitionContext.containerView
        
        switch self.type {
        case .fromLeftToRight:
            viewFromTransform = CATransform3DMakeRotation(-self.rotationAngle, 0.0, 1.0, 0.0)
            viewToTransform = CATransform3DMakeRotation(self.rotationAngle, 0.0, 1.0, 0.0)
            
            toView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
            fromView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            
            containerView.transform = CGAffineTransformMakeTranslation(-containerView.frame.width / 2, 0)
        case .fromRightToLeft:
            viewFromTransform = CATransform3DMakeRotation(self.rotationAngle, 0.0, 1.0, 0.0)
            viewToTransform = CATransform3DMakeRotation(-self.rotationAngle, 0.0, 1.0, 0.0)
            
            toView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            fromView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
            
            containerView.transform = CGAffineTransformMakeTranslation(containerView.frame.width / 2, 0)
        case .fromTopToBottom:
            viewFromTransform = CATransform3DMakeRotation(self.rotationAngle, 1.0, 0.0, 0.0)
            viewToTransform = CATransform3DMakeRotation(-self.rotationAngle, 1.0, 0.0, 0.0)
            
            fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
            
            containerView.transform = CGAffineTransformMakeTranslation(0, -containerView.frame.height / 2)
        case .fromBottomToTop:
            viewFromTransform = CATransform3DMakeRotation(-self.rotationAngle, 1.0, 0.0, 0.0)
            viewToTransform = CATransform3DMakeRotation(self.rotationAngle, 1.0, 0.0, 0.0)
            
            fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            
            containerView.transform = CGAffineTransformMakeTranslation(0, containerView.frame.width)
        }
        
        
        viewFromTransform.m34 = self.perspective
        viewToTransform.m34 = self.perspective
        
        toView.layer.transform = viewToTransform
        
        let fromShadow = self.addOpacity(fromView, color: .black)
        let toShadow = self.addOpacity(toView, color: .black)
        
        fromShadow.alpha = 0.0
        toShadow.alpha = 1.0

        containerView.addSubview(toView)
        
        UIView.animate(withDuration: duration) {
            switch self.type {
            case .fromLeftToRight:
                containerView.transform = CGAffineTransformMakeTranslation(containerView.frame.width / 2, 0)
            case .fromRightToLeft:
                containerView.transform = CGAffineTransformMakeTranslation(-containerView.frame.width / 2, 0)
            case .fromTopToBottom:
                containerView.transform = CGAffineTransformMakeTranslation(0, containerView.frame.height / 2)
            case .fromBottomToTop:
                containerView.transform = CGAffineTransformMakeTranslation(0, -containerView.frame.height / 2)
            }
            
            fromView.layer.transform = viewFromTransform
            toView.layer.transform = CATransform3DIdentity
            
            fromShadow.alpha = 1.0
            toShadow.alpha = 0.0
        } completion: { _ in
            containerView.transform = CGAffineTransformIdentity
            fromView.layer.transform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
            
            fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            fromShadow.removeFromSuperview()
            toShadow.removeFromSuperview()
            
//            if transitionContext.transitionWasCancelled {
//                toView.removeFromSuperview()
//            } else {
//                fromView.removeFromSuperview()
//            }
            
            fromView.frame = containerView.bounds
            toView.frame = containerView.bounds
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}

extension JWStackTransitionAnimationCube {
    
    /// add opacity to the given view
    /// - Parameters:
    ///   - view: the given view
    ///   - color: UIColor value
    func addOpacity(_ view: UIView, color: UIColor) -> UIView {
        let targetView = UIView(frame: view.bounds)
        targetView.backgroundColor = color.withAlphaComponent(0.8)
        view.addSubview(targetView)
        
        return targetView
    }
    
}

#endif
