//
//  JWStackTransitionAnimationCircle.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationCircle: JWStackTransitionAnimationDelegate {
    
    private var duration: TimeInterval = 0.25 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        self.duration = duration
        
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let fromW = fromView.frame.width
        let fromH = fromView.frame.height
        
        // pow(x,y) - 取x的y次幂, sqrt() - 取平方根
        let radius = sqrt(pow(fromW / 2, 2) + pow(fromH / 2, 2))
        let center = CGPoint(x: fromW / 2, y: fromH / 2)
        
        let pathStart = makePath(center, radius: radius)
        let pathEnd = makePath(center, radius: 1.0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pathStart
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        shapeLayer.position = center
        fromView.layer.mask = shapeLayer
        self.targetLayer = shapeLayer
        
        fromView.isUserInteractionEnabled = false
        addAnimation(from: pathStart, to: pathEnd) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromView.isUserInteractionEnabled = true
            fromView.layer.mask = nil
        }

    }
    
}

extension JWStackTransitionAnimationCircle {
    
    /// get animation path
    /// - Parameters:
    ///   - center: path arc ceter
    ///   - radius: path radius
    /// - Returns: CGPath
    func makePath(_ center: CGPoint, radius: CGFloat) -> CGPath {
        return UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(2.0 * .pi), clockwise: true).cgPath
    }
    
    /// add animation
    /// - Parameters:
    ///   - from: animation fromValue
    ///   - to: animation toValue
    ///   - complete: animation finished call back
    func addAnimation(from: CGPath, to: CGPath, complete: (() -> Void)?) {
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.duration = self.duration
        animation.fromValue = from
        animation.toValue = to
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.autoreverses = false
        animation.animationFinished = complete
        
        self.targetLayer.add(animation, forKey: "path")
    }
}

#endif
