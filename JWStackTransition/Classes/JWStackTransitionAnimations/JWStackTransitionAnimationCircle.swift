//
//  JWStackTransitionAnimationCircle.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationCircle: JWStackTransitionAnimationDelegate {
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
//        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        let fromW = fromVC.view.frame.width
        let fromH = fromVC.view.frame.height
        
        /// pow(x,y) - 取x的y次幂, sqrt() - 取平方根
        let radius = sqrt(pow(fromW / 2, 2) + pow(fromH / 2, 2))
        let pathStart = UIBezierPath(arcCenter: CGPoint(x: fromW / 2, y: fromH / 2), radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let pathEnd = UIBezierPath(arcCenter: CGPoint(x: fromW / 2, y: fromH / 2), radius: CGFloat(1), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
//        let pathStart = UIBezierPath(arcCenter: CGPoint(x: halfW, y: halfH), radius: CGFloat(radius), startAngle: CGFloat(Double.pi * 2), endAngle:CGFloat(0), clockwise: true)
//        let pathEnd = UIBezierPath(arcCenter: CGPoint(x: halfW, y: halfH), radius: CGFloat(1), startAngle: CGFloat(Double.pi * 2), endAngle:CGFloat(0), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pathStart.cgPath
        shapeLayer.bounds = CGRect.init(x: 0, y: 0, width: fromW, height: fromH)
        shapeLayer.position = CGPoint(x: fromW / 2 / 2, y: fromH / 2)
        shapeLayer.fillColor = toVC.view.backgroundColor?.cgColor
        fromVC.view.layer.mask = shapeLayer
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = duration
        animation.fromValue = pathStart.cgPath
        animation.toValue = pathEnd.cgPath
        animation.autoreverses = false
        animation.animationFinished = {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.layer.mask = nil
            
        }
        shapeLayer.add(animation, forKey: "path")
    }
    
}

#endif
