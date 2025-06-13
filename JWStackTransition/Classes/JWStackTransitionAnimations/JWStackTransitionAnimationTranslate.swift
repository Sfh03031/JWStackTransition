//
//  JWStackTransitionAnimationTranslate.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationTranslate: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationRectEdge = .left // animation translate direction type
    private var duration: TimeInterval = 0.7 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    
    public init(_ edge: JWStackTransitionAnimationRectEdge) {
        self.type = edge
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
        
        let fromPath = UIBezierPath(rect: fromView.bounds)
        var toPath = UIBezierPath()
        switch self.type {
        case .top:
            toPath = UIBezierPath(rect: CGRect(x: 0, y: fromH, width: fromW, height: 0))
        case .left:
            toPath = UIBezierPath(rect: CGRect(x: fromW, y: 0, width: fromW, height: fromH))
        case .right:
            toPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: fromH))
        case .bottom:
            toPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: fromW, height: 0))
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = fromPath.cgPath
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        fromView.layer.mask = maskLayer
        self.targetLayer = maskLayer
        
        addAnimation(from: fromPath.cgPath, to: toPath.cgPath) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromView.layer.mask = nil
        }
        
    }
    
}

extension JWStackTransitionAnimationTranslate {
    
    /// add animations
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
