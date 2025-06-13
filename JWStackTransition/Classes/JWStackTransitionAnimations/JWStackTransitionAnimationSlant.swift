//
//  JWStackTransitionAnimationSlant.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationSlant: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationRectCorner = .topLeft // animation start corner
    private var duration: TimeInterval = 0.25 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    
    public init(_ corner: JWStackTransitionAnimationRectCorner) {
        self.type = corner
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
        
        let fromPath = makeFromPath(width: fromW, height: fromH)
        let toPath = makeToPath(width: fromW, height: fromH)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = fromPath
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        shapeLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        fromView.layer.mask = shapeLayer
        self.targetLayer = shapeLayer
        
        fromView.isUserInteractionEnabled = false
        addAnimation(from: fromPath, to: toPath) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromView.isUserInteractionEnabled = true
            fromView.layer.mask = nil
        }
        
    }
    
}

extension JWStackTransitionAnimationSlant {
    
    /// get animation from path
    /// - Parameters:
    ///   - width: fromVC view width
    ///   - height: fromVC view height
    /// - Returns: CGPath
    func makeFromPath(width: CGFloat, height: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        switch self.type {
        case .topLeft:
            path.move(to: CGPoint(x: width, y: height * -2))
            path.addLine(to: CGPoint(x: -width, y: height))
            path.addLine(to: CGPoint(x: width, y: height))
            path.close()
            break
        case .topRight:
            path.move(to: CGPoint(x: 0, y: -height))
            path.addLine(to: CGPoint(x: width * 2, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.close()
            break
        case .bottomLeft:
            path.move(to: CGPoint(x: width, y: height * 2))
            path.addLine(to: CGPoint(x: -width, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.close()
            break
        case .bottomRight:
            path.move(to: CGPoint(x: 0, y: height * 2))
            path.addLine(to: CGPoint(x: width * 2, y: 0))
            path.addLine(to: CGPoint.zero)
            path.close()
            break
        }
        
        return path.cgPath
    }
    
    /// get animation to path
    /// - Parameters:
    ///   - width: fromVC view width
    ///   - height: fromVC view height
    /// - Returns: CGPath
    func makeToPath(width: CGFloat, height: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        switch self.type {
        case .topLeft:
            path.move(to: CGPoint(x: width * 2, y: height))
            path.addLine(to: CGPoint(x: 0, y: height * 2))
            path.addLine(to: CGPoint(x: width * 2, y: height * 2))
            path.close()
            break
        case .topRight:
            path.move(to: CGPoint(x: -width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height * 2))
            path.addLine(to: CGPoint(x: -width, y: height * 2))
            path.close()
            break
        case .bottomLeft:
            path.move(to: CGPoint(x: width * 2, y: height))
            path.addLine(to: CGPoint(x: 0, y: -height))
            path.addLine(to: CGPoint(x: width * 2, y: -height))
            path.close()
            break
        case .bottomRight:
            path.move(to: CGPoint(x: -width, y: height))
            path.addLine(to: CGPoint(x: width, y: -height))
            path.addLine(to: CGPoint(x: -width, y: -height))
            path.close()
            break
        }
        
        return path.cgPath
    }
    
    /// add animation
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
