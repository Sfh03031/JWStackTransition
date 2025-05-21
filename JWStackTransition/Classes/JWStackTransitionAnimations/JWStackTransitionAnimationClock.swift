//
//  JWStackTransitionAnimationClock.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationClock: JWStackTransitionAnimationDelegate {
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
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
        let radius = 2 * sqrt(pow(fromW / 2, 2) + pow(fromH / 2, 2))
        let circleCenter = CGPoint(x: radius ,y: radius)
        
        let circleFromToAngle : ((Double) -> (CGPath)) = { endAngle in
            let path = UIBezierPath()
            path.move(to: circleCenter)
            path.addLine(to: circleCenter)
            path.addArc(withCenter: circleCenter, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(endAngle), clockwise: true)
            
            return path.cgPath
        }
        
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.bounds = CGRect.init(x: 0, y: 0, width: radius, height: radius)
        shapeLayer.position = CGPoint(x: (fromW / 2) - (radius / 2), y: (fromH / 2) - (radius / 2))
        shapeLayer.path = circleFromToAngle(2.0 * Double.pi)
        
        fromVC.view.layer.mask = shapeLayer
        
        let cleanup : (() -> (Void)) = {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.layer.mask = nil
            fromVC.view.removeFromSuperview()
        }
        
        let runAnimationToPathWithCompletion : ((CGPath, CGPath, @escaping () -> (Void)) -> (Void)) = { pathStart, pathEnd, completion in
            let animation = JWStackTransitionBasicAnimation()
            animation.keyPath = "path"
            animation.duration = duration / 4
            animation.fromValue = pathStart
            animation.toValue = pathEnd
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            animation.autoreverses = false
            animation.animationFinished = {
                completion()
            }
            shapeLayer.add(animation, forKey: "path")
        }
        
//        runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 2.0), circleFromToAngle(Double.pi * 1.50001), {
//            runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 1.5), circleFromToAngle(Double.pi * 1.00001), {
//                runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 1.0), circleFromToAngle(Double.pi * 0.50001), {
//                    runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 0.5), circleFromToAngle(Double.pi * 0.0001), {
//                        cleanup()
//                    })
//                })
//            })
//        })
        
        runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 0.0001), circleFromToAngle(Double.pi * 0.5), {
            runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 0.50001), circleFromToAngle(Double.pi * 1.0), {
                runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 1.00001), circleFromToAngle(Double.pi * 1.5), {
                    runAnimationToPathWithCompletion(circleFromToAngle(Double.pi * 1.50001), circleFromToAngle(Double.pi * 2.0), {
                        cleanup()
                    })
                })
            })
        })
        
        
    }
    
}

#endif
