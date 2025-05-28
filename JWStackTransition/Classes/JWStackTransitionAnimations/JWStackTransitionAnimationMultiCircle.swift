//
//  JWStackTransitionAnimationMultiCircle.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationMultiCircle: JWStackTransitionAnimationDelegate {
    
    private var duration: TimeInterval = 0.25 // animation duration
    private var diameter: CGFloat = 20.0 // circle diameter, range is (0, 100]
    
    public init(_ diameter: CGFloat) {
        if diameter > 0 {
            self.diameter = diameter
        }
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
        self.diameter = min(self.diameter, 100)
        
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        
        let circleSize = CGSize(width: self.diameter, height: self.diameter)
        let rowNum = Int(ceil(fromH / self.diameter))
        let columnNum = Int(ceil(fromW / self.diameter))

        for i in 0..<rowNum {
            for j in 0..<columnNum {
                let center = CGPoint(x: self.diameter / 2 + CGFloat(j) * self.diameter, y: self.diameter / 2 + CGFloat(i) * self.diameter)
                
                let layer = getAnimationLayer(center: center, size: circleSize) {
                    if i == 0 && j == 0 {
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                        fromVC.view.layer.mask = nil
                    }
                }
                maskLayer.addSublayer(layer)
            }
        }
        
        fromVC.view.layer.mask = maskLayer
        
    }
    
}

extension JWStackTransitionAnimationMultiCircle {
    
    /// get single circle animation layer
    /// - Parameters:
    ///   - center: center of CAShapeLayer
    ///   - size: size of CAShapeLayer
    ///   - complete: animation finished call back
    /// - Returns: CAShapeLayer
    func getAnimationLayer(center: CGPoint, size: CGSize, complete: (() -> Void)? = nil) -> CAShapeLayer {
        let fromPath = UIBezierPath(arcCenter: center, radius: size.width, startAngle: 0.0, endAngle: CGFloat(2.0 * .pi), clockwise: true)
        let toPath = UIBezierPath(arcCenter: center, radius: 1.0, startAngle: 0.0, endAngle: CGFloat(2.0 * .pi), clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        maskLayer.position = center
        maskLayer.path = toPath.cgPath
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.duration = self.duration
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.autoreverses = false
        animation.fillMode = .forwards
        animation.animationFinished = complete
        
        maskLayer.add(animation, forKey: "path")
        
        return maskLayer
    }
}

#endif
