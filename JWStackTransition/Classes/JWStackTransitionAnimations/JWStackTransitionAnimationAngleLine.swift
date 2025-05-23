//
//  JWStackTransitionAnimationAngleLine.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationAngleLine: JWStackTransitionAnimationDelegate {
    
    private var rectCorner : UIRectCorner = .topLeft // animation start corner
    private var duration: TimeInterval = 0.25 // animation duration
    private var targetLayer: CAShapeLayer = CAShapeLayer() // animation layer
    
    public init(corner: UIRectCorner = .topLeft) {
        self.rectCorner = corner
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
        
        let fromPath = makeFromPath(width: fromW, height: fromH)
        let toPath = makeToPath(width: fromW, height: fromH)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = fromPath
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        shapeLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        fromVC.view.layer.mask = shapeLayer
        self.targetLayer = shapeLayer
        
        fromVC.view.isUserInteractionEnabled = false
        addAnimation(from: fromPath, to: toPath) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.isUserInteractionEnabled = true
            fromVC.view.layer.mask = nil
        }
        
    }
    
}

extension JWStackTransitionAnimationAngleLine {
    
    /// make animation from path
    func makeFromPath(width: CGFloat, height: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        switch self.rectCorner {
        case .topLeft, .allCorners:
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
        default:
            break
        }
        
        return path.cgPath
    }
    
    /// make animation to path
    func makeToPath(width: CGFloat, height: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        switch self.rectCorner {
        case .topLeft, .allCorners:
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
        default:
            break
        }
        
        return path.cgPath
    }
    
    /// run animations
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
