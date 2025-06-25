//
//  JWStackTransitionAnimationShiftLine.swift
//  Pods
//
//  Created by sfh on 2025/6/25.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationShiftLine: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationShiftLineType = .toRight // animation  type
    
    public init(_ type: JWStackTransitionAnimationShiftLineType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let fromW = fromView.frame.width
        let fromH = fromView.frame.height
        
        var fromPath = UIBezierPath()
        var toPath = UIBezierPath()
        
        switch self.type {
        case .toTop:
            fromPath = UIBezierPath(rect: fromView.bounds)
            toPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: fromW, height: 0))
        case .toRight:
            fromPath = UIBezierPath(rect: fromView.bounds)
            toPath = UIBezierPath(rect: CGRect(x: fromW, y: 0, width: fromW, height: fromH))
        case .toBottom:
            fromPath = UIBezierPath(rect: fromView.bounds)
            toPath = UIBezierPath(rect: CGRect(x: 0, y: fromH, width: fromW, height: 0))
        case .toLeft:
            fromPath = UIBezierPath(rect: fromView.bounds)
            toPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: fromH))
        case .toTopRight:
            fromPath.move(to: CGPoint(x: fromW, y: fromH * 2))
            fromPath.addLine(to: CGPoint(x: -fromW, y: 0))
            fromPath.addLine(to: CGPoint(x: fromW, y: 0))
            fromPath.close()
            
            toPath.move(to: CGPoint(x: fromW * 2, y: fromH))
            toPath.addLine(to: CGPoint(x: 0, y: -fromH))
            toPath.addLine(to: CGPoint(x: fromW * 2, y: -fromH))
            toPath.close()
            break
        case .toBottomRight:
            fromPath.move(to: CGPoint(x: fromW, y: fromH * -2))
            fromPath.addLine(to: CGPoint(x: -fromW, y: fromH))
            fromPath.addLine(to: CGPoint(x: fromW, y: fromH))
            fromPath.close()
            
            toPath.move(to: CGPoint(x: fromW * 2, y: fromH))
            toPath.addLine(to: CGPoint(x: 0, y: fromH * 2))
            toPath.addLine(to: CGPoint(x: fromW * 2, y: fromH * 2))
            toPath.close()
            break
        case .toBottomLeft:
            fromPath.move(to: CGPoint(x: 0, y: -fromH))
            fromPath.addLine(to: CGPoint(x: fromW * 2, y: fromH))
            fromPath.addLine(to: CGPoint(x: 0, y: fromH))
            fromPath.close()
            
            toPath.move(to: CGPoint(x: -fromW, y: 0))
            toPath.addLine(to: CGPoint(x: fromW, y: fromH * 2))
            toPath.addLine(to: CGPoint(x: -fromW, y: fromH * 2))
            toPath.close()
            break
        case .toTopLeft:
            fromPath.move(to: CGPoint(x: 0, y: fromH * 2))
            fromPath.addLine(to: CGPoint(x: fromW * 2, y: 0))
            fromPath.addLine(to: CGPoint.zero)
            fromPath.close()
            
            toPath.move(to: CGPoint(x: -fromW, y: fromH))
            toPath.addLine(to: CGPoint(x: fromW, y: -fromH))
            toPath.addLine(to: CGPoint(x: -fromW, y: -fromH))
            toPath.close()
            break
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = fromPath.cgPath
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        
        fromView.isUserInteractionEnabled = false
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.duration = duration
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.autoreverses = false
        animation.animationFinished = {
            fromView.layer.mask = nil
            fromView.isUserInteractionEnabled = true
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        maskLayer.add(animation, forKey: "path")
        
        fromView.layer.mask = maskLayer
        
    }
    
}

#endif
