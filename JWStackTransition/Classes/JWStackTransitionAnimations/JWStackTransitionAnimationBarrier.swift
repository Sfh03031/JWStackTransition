//
//  JWStackTransitionAnimationBarrier.swift
//  Pods
//
//  Created by sfh on 2025/5/30.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationBarrier: JWStackTransitionAnimationDelegate {

    private var type: JWStackTransitionAnimationBarrierFadeDirectionType = .toTop // animation fencebar type
    private var fenceWidth: CGFloat = 20.0 // animation fence bar width
    
    /// init
    /// - Parameters:
    ///   - type: case of JWStackTransitionAnimationFenceType
    ///   - width: fence bar width
    public init(_ type: JWStackTransitionAnimationBarrierFadeDirectionType, width: CGFloat) {
        self.type = type
        self.fenceWidth = width
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let tempView = UIView()
        tempView.frame = fromView.frame
        tempView.addSubview(fromView)
        containerView.addSubview(tempView)
        
        let fromW = fromView.frame.width
        let fromH = fromView.frame.height
        
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        
        let maskSize = fromView.bounds.size
        
        switch self.type {
        case .toTop, .toBottom, .toVerticalCenter:
            let fenceNum = Int(ceil(fromW / self.fenceWidth))
            let fenceW = self.fenceWidth
            for i in 0...fenceNum {
                let random = Float(arc4random()) / Float(UInt32.max)
                let time = TimeInterval(Float(duration / 4 * 3) * random + Float(duration / 4))
                
                let from = UIBezierPath()
                from.move(to: CGPoint(x: CGFloat(i) * fenceW, y: 0))
                from.addLine(to: CGPoint(x: CGFloat(i + 1) * fenceW, y: 0))
                from.addLine(to: CGPoint(x: CGFloat(i + 1) * fenceW, y: fromH))
                from.addLine(to: CGPoint(x: CGFloat(i) * fenceW, y: fromH))
                
                var toY = 0.0
                if self.type == .toBottom {
                    toY = fromH
                }
                if self.type == .toVerticalCenter {
                    toY = fromH / 2
                }
                let to = UIBezierPath(rect: CGRect(x: CGFloat(i) * fenceW, y: toY, width: fenceW, height: 0))
                let subLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, duration: time)
                maskLayer.addSublayer(subLayer)
            }
            break
        case .toLeft, .toRight, .toHorizontalCenter:
            let fenceNum = Int(ceil(fromH / self.fenceWidth))
            let fenceH = self.fenceWidth
            for i in 0...fenceNum {
                let random = Float(arc4random()) / Float(UInt32.max)
                let time = TimeInterval(Float(duration / 4 * 3) * random + Float(duration / 4))
                
                let from = UIBezierPath()
                from.move(to: CGPoint(x: 0, y: CGFloat(i) * fenceH))
                from.addLine(to: CGPoint(x: fromW, y: CGFloat(i) * fenceH))
                from.addLine(to: CGPoint(x: fromW, y: CGFloat(i + 1) * fenceH))
                from.addLine(to: CGPoint(x: 0, y: CGFloat(i + 1) * fenceH))
                
                var toX = 0.0
                if self.type == .toRight {
                    toX = fromW
                }
                if self.type == .toHorizontalCenter {
                    toX = fromW / 2
                }
                let to = UIBezierPath(rect: CGRect(x: toX, y: CGFloat(i) * fenceH, width: 0, height: fenceH))
                let subLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, duration: time)
                maskLayer.addSublayer(subLayer)
            }
            break
        }
        
        JWStackTransition.delay(second: duration) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            tempView.layer.mask = nil
            tempView.removeFromSuperview()
        }
        
        tempView.layer.mask = maskLayer

    }
    
}

extension JWStackTransitionAnimationBarrier {
    
    /// get animation layer
    /// - Parameters:
    ///   - size: shap layer size
    ///   - fromPath: animation fromValue
    ///   - toPath: animation toValue
    ///   - complete: animation finished call back
    func getAnimationLayer(size: CGSize, fromPath: UIBezierPath, toPath: UIBezierPath, duration: TimeInterval) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = fromPath.cgPath
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        shapeLayer.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = duration
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.autoreverses = false
        animation.animationFinished = nil
        
        shapeLayer.add(animation, forKey: "path")
        
        return shapeLayer
    }

}

#endif
