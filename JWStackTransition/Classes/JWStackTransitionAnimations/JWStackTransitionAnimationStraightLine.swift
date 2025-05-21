//
//  JWStackTransitionAnimationStraightLine.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationStraightLine: JWStackTransitionAnimationDelegate {
    
    private var sideToSlideFrom : UIRectEdge = .left
    
    public init(rectEdge: UIRectEdge = .left) {
        self.sideToSlideFrom = rectEdge
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        let size: CGSize = fromVC.view.frame.size
        
        var toPath = UIBezierPath()
        let fromPath = UIBezierPath(rect: fromVC.view.bounds)
        
        if (sideToSlideFrom == .top) {
            toPath = UIBezierPath(rect: CGRect.init(x: 0, y: size.height, width: size.width, height: 0))
        } else if (sideToSlideFrom == .left) {
            toPath = UIBezierPath(rect: CGRect.init(x: size.width, y: 0, width: size.width, height: size.height))
        } else if (sideToSlideFrom == .right) {
            toPath = UIBezierPath(rect: CGRect.init(x: 0, y: 0, width: 0, height: size.height))
        } else if (sideToSlideFrom == .bottom) {
            toPath = UIBezierPath(rect: CGRect.init(x: 0, y: 0, width: size.width, height: 0))
        }
        
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = fromPath.cgPath
        shapeLayer.bounds = CGRect.init(x: 0, y: 0, width: fromVC.view.bounds.size.width, height: fromVC.view.bounds.size.height)
        shapeLayer.position = CGPoint(x: fromVC.view.bounds.size.width / 2, y: fromVC.view.bounds.size.height / 2)
        
        fromVC.view.layer.mask = shapeLayer
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = duration
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.autoreverses = false
        animation.animationFinished = {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.layer.mask = nil
        }
        shapeLayer.add(animation, forKey: "path")
    }
    
}

#endif
