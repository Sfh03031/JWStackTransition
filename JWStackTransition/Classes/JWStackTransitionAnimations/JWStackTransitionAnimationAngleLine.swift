//
//  JWStackTransitionAnimationAngleLine.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationAngleLine: JWStackTransitionAnimationDelegate {
    
    private var cornerToSlideFrom : UIRectCorner = .topLeft
    
    public init(corner: UIRectCorner = .topLeft) {
        self.cornerToSlideFrom = corner
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
        
        let toPath = UIBezierPath()
        let fromPath = UIBezierPath()
        
        if (cornerToSlideFrom == .topRight) {
            toPath.move(to: CGPoint.init(x: -size.width, y: 0))
            toPath.addLine(to: CGPoint.init(x: size.width, y: size.height * 2))
            toPath.addLine(to: CGPoint.init(x: -size.width, y: size.height * 2))
            toPath.close()
            
            fromPath.move(to: CGPoint.init(x: 0, y: -size.height))
            fromPath.addLine(to: CGPoint.init(x: size.width * 2, y: size.height))
            fromPath.addLine(to: CGPoint.init(x: 0, y: size.height))
            fromPath.close()
        } else if (cornerToSlideFrom == .bottomLeft) {
            toPath.move(to: CGPoint.init(x: size.width * 2, y: size.height))
            toPath.addLine(to: CGPoint.init(x: 0, y: -size.height))
            toPath.addLine(to: CGPoint.init(x: size.width * 2, y: -size.height))
            toPath.close()
            
            fromPath.move(to: CGPoint.init(x: size.width, y: size.height * 2))
            fromPath.addLine(to: CGPoint.init(x: -size.width, y: 0))
            fromPath.addLine(to: CGPoint.init(x: size.width, y: 0))
            fromPath.close()
        } else if (cornerToSlideFrom == .bottomRight) {
            toPath.move(to: CGPoint.init(x: -size.width, y: size.height))
            toPath.addLine(to: CGPoint.init(x: size.width, y: -size.height))
            toPath.addLine(to: CGPoint.init(x: -size.width, y: -size.height))
            toPath.close()
            
            fromPath.move(to: CGPoint.init(x: 0, y: size.height * 2))
            fromPath.addLine(to: CGPoint.init(x: size.width * 2, y: 0))
            fromPath.addLine(to: CGPoint.zero)
            fromPath.close()
        } else if (cornerToSlideFrom == .topLeft) {
            toPath.move(to: CGPoint.init(x: size.width * 2, y: size.height))
            toPath.addLine(to: CGPoint.init(x: 0, y: size.height * 2))
            toPath.addLine(to: CGPoint.init(x: size.width * 2, y: size.height * 2))
            toPath.close()
            
            fromPath.move(to: CGPoint.init(x: size.width, y: size.height * -2))
            fromPath.addLine(to: CGPoint.init(x: -size.width, y: size.height))
            fromPath.addLine(to: CGPoint.init(x: size.width, y: size.height))
            fromPath.close()
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
