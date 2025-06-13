//
//  JWStackTransitionAnimationClockWise.swift
//  Pods
//
//  Created by sfh on 2025/5/21.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationClockWise: JWStackTransitionAnimationDelegate {
    
    private var center: CGPoint = CGPoint() // animation path center
    private var radius: CGFloat = 0.0 // animation path radius
    private var duration: TimeInterval = 0.25 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    private var startAngle: Double = 0.5 // animation start angle
    
    public init(_ startAngle: Double) {
        self.startAngle = startAngle
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        self.duration = duration
        
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let fromW = fromView.frame.width
        let fromH = fromView.frame.height
        
        /// pow(x,y) - 取x的y次幂, sqrt() - 取平方根
        self.radius = 2 * sqrt(pow(fromW / 2, 2) + pow(fromH / 2, 2))
        self.center = CGPoint(x: self.radius ,y: self.radius)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: self.radius, height: self.radius)
        shapeLayer.position = CGPoint(x: (fromW - self.radius) / 2, y: (fromH - self.radius) / 2)
        shapeLayer.path = makePath(-(self.startAngle + 2.0) * .pi)
        fromView.layer.mask = shapeLayer
        self.targetLayer = shapeLayer
        
        fromView.isUserInteractionEnabled = false
        let angleFrom = self.startAngle + 2.0
        self.addAnimation(from: makePath(-angleFrom * .pi), to: makePath(-(angleFrom - 0.5 + 0.00001) * .pi)) {
            self.addAnimation(from: self.makePath(-(angleFrom - 0.5) * .pi), to: self.makePath(-(angleFrom - 1.0 + 0.00001) * .pi)) {
                self.addAnimation(from: self.makePath(-(angleFrom - 1.0) * .pi), to: self.makePath(-(angleFrom - 1.5 + 0.00001) * .pi)) {
                    self.addAnimation(from: self.makePath(-(angleFrom - 1.5) * .pi), to: self.makePath(-(angleFrom - 2.0 + 0.00001) * .pi)) {
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                        fromView.isUserInteractionEnabled = true
                        fromView.layer.mask = nil
                    }
                }
            }
        }
        
    }
    
}

extension JWStackTransitionAnimationClockWise {
    
    /// make animation path
    /// - Parameter endAngle: path end angle
    /// - Returns: CGPath
    func makePath(_ endAngle: CGFloat) -> CGPath {
        let path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: center)
        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(-self.startAngle * .pi), endAngle:CGFloat(endAngle), clockwise: false)
        
        return path.cgPath
    }
    
    /// add animations
    /// - Parameters:
    ///   - from: animation fromValue
    ///   - to: animation toValue
    ///   - complete: animation finished call back
    func addAnimation(from: CGPath, to: CGPath, complete: (() -> Void)?) {
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.duration = self.duration / 4
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
