//
//  JWStackTransitionAnimationAntiClockWise.swift
//  Pods
//
//  Created by sfh on 2025/5/21.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationAntiClockWise: JWStackTransitionAnimationDelegate {
    
    private var center: CGPoint = CGPoint() // animation path center
    private var radius: CGFloat = 0.0 // animation path radius
    private var duration: TimeInterval = 0.25 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    private var startAngle: Double = 0
    
//    public init(_ startAngle: Double) {
//        self.startAngle = startAngle
//    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        self.duration = duration
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        let fromW = fromVC.view.frame.width
        let fromH = fromVC.view.frame.height
        
        /// pow(x,y) - 取x的y次幂, sqrt() - 取平方根
        self.radius = 2 * sqrt(pow(fromW / 2, 2) + pow(fromH / 2, 2))
//        self.radius = fromW / 2
        self.center = CGPoint(x: self.radius ,y: self.radius)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect.init(x: 0, y: 0, width: self.radius, height: self.radius)
        shapeLayer.position = CGPoint(x: (fromW - self.radius) / 2, y: (fromH - self.radius) / 2)
//        shapeLayer.path = self.makePath(2.0 * .pi)
        shapeLayer.path = self.makePath(3.5 * .pi)
        fromVC.view.layer.mask = shapeLayer
        self.targetLayer = shapeLayer
        
//        self.addAnimation(from: makePath(2.0 * .pi), to: makePath(1.50001 * .pi)) {
//            self.addAnimation(from: self.makePath(1.5 * .pi), to: self.makePath(1.00001 * .pi)) {
//                self.addAnimation(from: self.makePath(1.0 * .pi), to: self.makePath(0.50001 * .pi)) {
//                    self.addAnimation(from: self.makePath(0.5 * .pi), to: self.makePath(0.00001 * .pi)) {
//                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                        fromVC.view.layer.mask = nil
//                        fromVC.view.removeFromSuperview()
//                    }
//                }
//            }
//        }
        
        self.addAnimation(from: makePath(3.5 * .pi), to: makePath(3.00001 * .pi)) {
            self.addAnimation(from: self.makePath(3.0 * .pi), to: self.makePath(2.50001 * .pi)) {
                self.addAnimation(from: self.makePath(2.5 * .pi), to: self.makePath(2.00001 * .pi)) {
                    self.addAnimation(from: self.makePath(2.0 * .pi), to: self.makePath(1.50001 * .pi)) {
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                        fromVC.view.layer.mask = nil
                        fromVC.view.removeFromSuperview()
                    }
                }
            }
        }
        
    }
    
}

extension JWStackTransitionAnimationAntiClockWise {
    
    /// make animation path
    func makePath(_ endAngle: CGFloat) -> CGPath {
        let path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: center)
//        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(endAngle), clockwise: true)
        
        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(1.5 * .pi), endAngle:CGFloat(endAngle), clockwise: true)
        
        return path.cgPath
    }
    
    /// run animations
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
