//
//  JWStackTransitionAnimationSector.swift
//  Pods
//
//  Created by sfh on 2025/5/23.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationSector: JWStackTransitionAnimationDelegate {
    
    private var duration: TimeInterval = 0.25 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    private var rectEdge : UIRectEdge = .left // animation sector rect edge
    
    public init(rectEdge: UIRectEdge = .left) {
        self.rectEdge = rectEdge
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
        
        let radius = makePathRadius(width: fromW, height: fromH)
        let center = makeCenterPoint(width: fromW, height: fromH)
        
        let pathStart = makePath(center, radius: radius)
        let pathEnd = makePath(center, radius: 1.0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pathStart
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        shapeLayer.position = center
        fromVC.view.layer.mask = shapeLayer
        self.targetLayer = shapeLayer
        
        fromVC.view.isUserInteractionEnabled = false
        addAnimation(from: pathStart, to: pathEnd) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.isUserInteractionEnabled = true
            fromVC.view.layer.mask = nil
        }

    }
    
}

extension JWStackTransitionAnimationSector {
    
    /// get animation path radius
    /// - Parameters:
    ///   - width: fromVC view width
    ///   - height: fromVC view height
    /// - Returns: CGFloat
    func makePathRadius(width: CGFloat, height: CGFloat) -> CGFloat {
        var target: CGFloat = 0.0
        
        switch self.rectEdge {
        case .left, .right, .all:
            target = sqrt(pow(width, 2) + pow(height, 2)) // pow(x,y) - 取x的y次幂, sqrt() - 取平方根
        case .top, .bottom:
            target = height
        default:
            break
        }
        
        return target
    }
    
    /// get animation center point
    /// - Parameters:
    ///   - width: fromVC view width
    ///   - height: fromVC view height
    /// - Returns: CGFloat
    func makeCenterPoint(width: CGFloat, height: CGFloat) -> CGPoint {
        var point = CGPoint()
        
        switch self.rectEdge {
        case .left, .all:
            point = CGPoint(x: 0, y: height / 2)
        case .top:
            point = CGPoint(x: width / 2, y: width / 2)
        case .right:
            point = CGPoint(x: width, y: height / 2)
        case .bottom:
            point = CGPoint(x: width / 2, y: height - width / 2)
        default:
            break
        }
        
        return point
    }
    
    
    /// get animation path
    /// - Parameters:
    ///   - center: arcCenter of path
    ///   - radius: radius of path
    /// - Returns: CGPath
    func makePath(_ center: CGPoint, radius: CGFloat) -> CGPath {
        return UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: CGFloat(0), endAngle:CGFloat(2.0 * .pi), clockwise: true).cgPath
    }
    
    
    /// run animations
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
