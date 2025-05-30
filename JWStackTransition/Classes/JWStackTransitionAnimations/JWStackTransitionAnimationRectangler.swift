//
//  JWStackTransitionAnimationRectangler.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationRectangler: JWStackTransitionAnimationDelegate {
    
    private var increment: CGFloat = 20.0
    private var duration: TimeInterval = 0.25 // animation duration
    private var wave: JWStackTransitionAnimationRectanglerWave = .waveIn
    
    public init(_ wave: JWStackTransitionAnimationRectanglerWave) {
        self.wave = wave
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        self.duration = duration
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        let fromW = fromVC.view.frame.width
        let fromH = fromVC.view.frame.height
        
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        
        for i in 0...10 {
            let magnitude = CGFloat(i) * self.increment
            if magnitude <= fromW && magnitude <= fromH {
                let startRect = fromVC.view.bounds.toIncrement(magnitude)
                if let sublayer = getAnimationLayer(startRect) {
                    maskLayer.addSublayer(sublayer)
                }
            }
        }
        
        fromVC.view.layer.mask = maskLayer
        
        UIView.animate(withDuration: duration) {
            fromVC.view.alpha = 0.0
        } completion: { finished in
            if finished {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                fromVC.view.alpha = 1
                fromVC.view.layer.mask = nil
            }
        }

    }
    
}

extension JWStackTransitionAnimationRectangler {
    
    /// get animation layer
    /// - Parameter outerRect: rect
    /// - Returns: CAShapeLayer
    func getAnimationLayer(_ outerRect: CGRect) -> CAShapeLayer? {
        let increment = self.increment * 0.2
        if self.increment >= outerRect.width || self.increment >= outerRect.height { return nil }
        let innerRect = outerRect.toIncrement(increment)
        if self.increment >= innerRect.width || self.increment >= innerRect.height { return nil }
        
        let toPath = UIBezierPath(rect: outerRect)
        toPath.append(UIBezierPath(rect: innerRect))
        toPath.usesEvenOddFillRule = true
        
        let fromPath = UIBezierPath(rect: outerRect)
        fromPath.append(UIBezierPath(rect: innerRect.toIncrement(self.increment)))
        fromPath.usesEvenOddFillRule = true
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: outerRect.width, height: outerRect.height)
        shapeLayer.position = CGPoint(x: outerRect.width / 2, y: outerRect.height / 2)
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shapeLayer.path = self.wave == .waveOut ? fromPath.cgPath : toPath.cgPath
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.duration = self.duration
        animation.fromValue = self.wave == .waveOut ? fromPath.cgPath : toPath.cgPath
        animation.toValue = self.wave == .waveOut ? toPath.cgPath : fromPath.cgPath
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.animationFinished = nil
        
        shapeLayer.add(animation, forKey: "path")
        
        return shapeLayer
    }
    
}
#endif
