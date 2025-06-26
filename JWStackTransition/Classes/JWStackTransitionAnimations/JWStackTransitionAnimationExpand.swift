//
//  JWStackTransitionAnimationExpand.swift
//  Pods
//
//  Created by sfh on 2025/6/26.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationExpand: JWStackTransitionAnimationDelegate {
    
    private var fromRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0) // animation from rect
    
    public init(_ fromRect: CGRect) {
        self.fromRect = fromRect
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let fromW = fromView.frame.width
        let fromH = fromView.frame.height
        
        let fromPath = UIBezierPath(ovalIn: self.fromRect)
        
        let centerX = self.fromRect.origin.x + self.fromRect.width / 2
        let centerY = self.fromRect.origin.y + self.fromRect.height / 2
        
        let radiusW = centerX > fromW / 2 ? centerX : fromW - centerX
        let radiusH = centerY > fromH / 2 ? centerY : fromH - centerY
 
        let radius = sqrt(pow(radiusW, 2) + pow(radiusH, 2))
        let toPath = UIBezierPath(ovalIn: CGRectInset(self.fromRect, -radius, -radius))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = toPath.cgPath
        toView.layer.mask = shapeLayer
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.duration = duration
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.autoreverses = false
        animation.animationFinished = {
            toView.layer.mask = nil
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        shapeLayer.add(animation, forKey: "path")

    }
    
}

#endif
