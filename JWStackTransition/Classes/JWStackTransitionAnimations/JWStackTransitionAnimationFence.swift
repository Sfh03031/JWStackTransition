//
//  JWStackTransitionAnimationFence.swift
//  Pods
//
//  Created by sfh on 2025/5/30.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationFence: JWStackTransitionAnimationDelegate {

    private var type: JWStackTransitionAnimationFenceType = .verticalLeft // animation fencebar type
    private var fenceWidth: CGFloat = 20.0 // animation fence bar width
    
    /// init
    /// - Parameters:
    ///   - type: case of JWStackTransitionAnimationFenceType
    ///   - width: fence bar width
    public init(_ type: JWStackTransitionAnimationFenceType, width: CGFloat) {
        self.type = type
        self.fenceWidth = width
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        let fromW = fromVC.view.frame.width
        let fromH = fromVC.view.frame.height
        
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        
        let maskSize = fromVC.view.bounds.size
        
        
        switch self.type {
        case .verticalLeft, .verticalRight:
            let fenceNum = Int(ceil(fromW / self.fenceWidth))
            let fenceW = self.fenceWidth
            for i in 0...fenceNum {
                let from = UIBezierPath()
                from.move(to: CGPoint(x: CGFloat(i) * fenceW, y: 0))
                from.addLine(to: CGPoint(x: CGFloat(i + 1) * fenceW, y: 0))
                from.addLine(to: CGPoint(x: CGFloat(i + 1) * fenceW, y: fromH))
                from.addLine(to: CGPoint(x: CGFloat(i) * fenceW, y: fromH))
                
                let toX = self.type == .verticalLeft ? CGFloat(i) * fenceW : CGFloat(i + 1) * fenceW
                let to = UIBezierPath(rect: CGRect(x: toX, y: 0, width: 0, height: fromH))
                let topLeftLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, duration: duration)
                maskLayer.addSublayer(topLeftLayer)
            }
            break
        case .horizontalTop, .horizontalBottom:
            let fenceNum = Int(ceil(fromH / self.fenceWidth))
            let fenceH = self.fenceWidth
            for i in 0...fenceNum {
                let from = UIBezierPath()
                from.move(to: CGPoint(x: 0, y: CGFloat(i) * fenceH))
                from.addLine(to: CGPoint(x: fromW, y: CGFloat(i) * fenceH))
                from.addLine(to: CGPoint(x: fromW, y: CGFloat(i + 1) * fenceH))
                from.addLine(to: CGPoint(x: 0, y: CGFloat(i + 1) * fenceH))
                
                let toY = self.type == .horizontalTop ? CGFloat(i) * fenceH : CGFloat(i + 1) * fenceH
                let to = UIBezierPath(rect: CGRect(x: 0, y: toY, width: fromW, height: 0))
                let topLeftLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, duration: duration)
                maskLayer.addSublayer(topLeftLayer)
            }
            break
        case .verticalCross:
            let fenceNum = Int(ceil(fromW / self.fenceWidth))
            let fenceW = self.fenceWidth
            for i in 0...fenceNum {
                let from = UIBezierPath()
                from.move(to: CGPoint(x: CGFloat(i) * fenceW, y: 0))
                from.addLine(to: CGPoint(x: CGFloat(i + 1) * fenceW, y: 0))
                from.addLine(to: CGPoint(x: CGFloat(i + 1) * fenceW, y: fromH))
                from.addLine(to: CGPoint(x: CGFloat(i) * fenceW, y: fromH))
                
                let toY = i % 2 == 0 ? 0 : fromH
                let to = UIBezierPath(rect: CGRect(x: CGFloat(i) * fenceW, y: toY, width: fenceW, height: 0))
                let topLeftLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, duration: duration)
                maskLayer.addSublayer(topLeftLayer)
            }
            break
        case .horizontalCross:
            let fenceNum = Int(ceil(fromH / self.fenceWidth))
            let fenceH = self.fenceWidth
            for i in 0...fenceNum {
                let from = UIBezierPath()
                from.move(to: CGPoint(x: 0, y: CGFloat(i) * fenceH))
                from.addLine(to: CGPoint(x: fromW, y: CGFloat(i) * fenceH))
                from.addLine(to: CGPoint(x: fromW, y: CGFloat(i + 1) * fenceH))
                from.addLine(to: CGPoint(x: 0, y: CGFloat(i + 1) * fenceH))
                
                let toX = i % 2 == 0 ? 0 : fromW
                let to = UIBezierPath(rect: CGRect(x: toX, y: CGFloat(i) * fenceH, width: 0, height: fenceH))
                let topLeftLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, duration: duration)
                maskLayer.addSublayer(topLeftLayer)
            }
            break
        }
        
        fromVC.view.isUserInteractionEnabled = false
        JWStackTransition.delay(second: duration) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fromVC.view.isUserInteractionEnabled = true
            fromVC.view.layer.mask = nil
        }
        
        fromVC.view.layer.mask = maskLayer

    }
    
}

extension JWStackTransitionAnimationFence {
    
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
