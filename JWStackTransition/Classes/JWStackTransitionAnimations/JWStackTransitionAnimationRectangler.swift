//
//  JWStackTransitionAnimationRectangler.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationRectangler: JWStackTransitionAnimationDelegate {
    
    static let RectangleGrowthDistance : CGFloat = 60
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        func createRectOutlinePath(_ outerRect: CGRect, completion: (() -> (Void))? = nil) -> CAShapeLayer? {
            let magnitude = (Self.RectangleGrowthDistance * 0.2)
            if (Self.RectangleGrowthDistance >= outerRect.size.width || Self.RectangleGrowthDistance >= outerRect.size.height) {
                return nil
            }
            let innerRect = outerRect.toIncrement(magnitude)
            if (Self.RectangleGrowthDistance >= innerRect.size.width || Self.RectangleGrowthDistance >= innerRect.size.height) {
                return nil
            }
            
            let path = UIBezierPath(rect: outerRect)
            path.append(UIBezierPath(rect: innerRect))
            path.usesEvenOddFillRule = true
            
            let finalPath = UIBezierPath(rect: outerRect)
            finalPath.append(UIBezierPath(rect: innerRect.toIncrement(Self.RectangleGrowthDistance)))
            finalPath.usesEvenOddFillRule = true
            
            let runAnimationToPathWithCompletion : ((CGPath, CAShapeLayer, (() -> (Void))?) -> (Void)) = { pathEnd, layer, completion in
                let animation = JWStackTransitionBasicAnimation()
                animation.keyPath = "path"
                animation.duration = duration
                animation.fromValue = pathEnd
                animation.toValue = path.cgPath
                animation.autoreverses = false
                animation.isRemovedOnCompletion = false
                animation.animationFinished = {
                    if let completion = completion {
                        completion()
                    }
                }
                layer.add(animation, forKey: "path")
            }
            
            let shapeLayer = CAShapeLayer.init()
            shapeLayer.bounds = CGRect.init(x: 0, y: 0, width: outerRect.size.width, height: outerRect.size.height)
            shapeLayer.position = CGPoint(x: outerRect.size.width / 2, y: outerRect.size.height / 2)
            shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
            shapeLayer.path = path.cgPath
            
            runAnimationToPathWithCompletion(finalPath.cgPath, shapeLayer, completion);
            
            return shapeLayer
        }
        
        let cleanup : (() -> (Void)) = {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.alpha = 1
            fromVC.view.layer.mask = nil
        }
        
        let maskLayer = CALayer.init()
        maskLayer.bounds = CGRect.init(x: 0, y: 0, width: fromVC.view.bounds.size.width, height: fromVC.view.bounds.size.height)
        maskLayer.position = CGPoint(x: fromVC.view.bounds.size.width / 2, y: fromVC.view.bounds.size.height / 2)
        
        for i in (0..<8) {
            let magnitude = CGFloat(i) * Self.RectangleGrowthDistance
            if magnitude <= fromVC.view.bounds.width && magnitude <= fromVC.view.bounds.height {
                let startRect = fromVC.view.bounds.toIncrement(magnitude)
                if let sublayer = createRectOutlinePath(startRect, completion: nil) {
                    maskLayer.addSublayer(sublayer)
                }
            }
        }
        
        fromVC.view.layer.mask = maskLayer
        
        UIView.animate(withDuration: duration) {
            fromVC.view.alpha = 0.0
        }
        
        JWStackTransition.delay(second: TimeInterval(duration)) {
            cleanup()
        }
    }
    
}

#endif
