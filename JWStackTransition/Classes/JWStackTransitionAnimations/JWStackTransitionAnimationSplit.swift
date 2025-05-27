//
//  JWStackTransitionAnimationSplit.swift
//  Pods
//
//  Created by sfh on 2025/5/26.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationSplit: JWStackTransitionAnimationDelegate {

    private var type: JWStackTransitionAnimationSplitType = .horizontal // animation split type
    private var duration: TimeInterval = 0.25 // animation duration
    
    public init(_ type: JWStackTransitionAnimationSplitType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        self.duration = duration
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        
        switch self.type {
        case .vertical, .horizontal, .leftDiagonal, .rightDiagonal, .crossDiagonal:
            containerView.addSubview(toVC.view)
            containerView.addSubview(fromVC.view)
            fromVC.view.isUserInteractionEnabled = false
            break
        case .diamondVertical, .diamondHorizontal:
            containerView.addSubview(fromVC.view)
            containerView.addSubview(toVC.view)
            break
        }
        
        let fromW = fromVC.view.frame.width
        let fromH = fromVC.view.frame.height
        
        let maskLayer = CALayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: fromW, height: fromH)
        maskLayer.position = CGPoint(x: fromW / 2, y: fromH / 2)
        
        let maskSize = fromVC.view.bounds.size
        
        let complete = {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            switch self.type {
            case .vertical, .horizontal, .leftDiagonal, .rightDiagonal, .crossDiagonal:
                fromVC.view.isUserInteractionEnabled = true
                fromVC.view.layer.mask = nil
                break
            case .diamondVertical, .diamondHorizontal:
                toVC.view.layer.mask = nil
                break
            }
        }
        
        switch self.type {
        case .horizontal:
            let from = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: fromW / 2, height: fromH), cornerRadius: 0)
            let to = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0, height: fromH), cornerRadius: 0)
            let layer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(layer)
            
            let from1 = UIBezierPath(roundedRect: CGRect(x: fromW / 2, y: 0, width: fromW / 2, height: fromH), cornerRadius: 0)
            let to1 = UIBezierPath(roundedRect: CGRect(x: fromW, y: 0, width: 0, height: fromH), cornerRadius: 0)
            let layer1 = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: complete)
            maskLayer.addSublayer(layer1)
            break
        case .vertical:
            let from = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: fromW, height: fromH / 2), cornerRadius: 0)
            let to = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: fromW, height: 0), cornerRadius: 0)
            let layer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(layer)
            
            let from1 = UIBezierPath(roundedRect: CGRect(x: 0, y: fromH / 2, width: fromW, height: fromH / 2), cornerRadius: 0)
            let to1 = UIBezierPath(roundedRect: CGRect(x: 0, y: fromH, width: fromW, height: 0), cornerRadius: 0)
            let layer1 = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: complete)
            maskLayer.addSublayer(layer1)
            break
        case .leftDiagonal:
            let from = UIBezierPath()
            from.move(to: CGPoint(x: 0, y: 0))
            from.addLine(to: CGPoint(x: fromW, y: 0))
            from.addLine(to: CGPoint(x: 0, y: fromH))
            from.close()
            let to = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0, height: 0), cornerRadius: 0)
            let layer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(layer)
            
            let from1 = UIBezierPath()
            from1.move(to: CGPoint(x: fromW, y: 0))
            from1.addLine(to: CGPoint(x: fromW, y: fromH))
            from1.addLine(to: CGPoint(x: 0, y: fromH))
            from1.close()
            let to1 = UIBezierPath(roundedRect: CGRect(x: fromW, y: fromH, width: 0, height: 0), cornerRadius: 0)
            let layer1 = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: complete)
            maskLayer.addSublayer(layer1)
            break
        case .rightDiagonal:
            let from = UIBezierPath()
            from.move(to: CGPoint(x: 0, y: 0))
            from.addLine(to: CGPoint(x: fromW, y: fromH))
            from.addLine(to: CGPoint(x: 0, y: fromH))
            from.close()
            let to = UIBezierPath(roundedRect: CGRect(x: 0, y: fromH, width: 0, height: 0), cornerRadius: 0)
            let layer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(layer)
            
            let from1 = UIBezierPath()
            from1.move(to: CGPoint(x: 0, y: 0))
            from1.addLine(to: CGPoint(x: fromW, y: 0))
            from1.addLine(to: CGPoint(x: fromW, y: fromH))
            from1.close()
            let to1 = UIBezierPath(roundedRect: CGRect(x: fromW, y: 0, width: 0, height: 0), cornerRadius: 0)
            let layer1 = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: complete)
            maskLayer.addSublayer(layer1)
            break
        case .crossDiagonal:
            let from = UIBezierPath()
            from.move(to: CGPoint(x: 0, y: 0))
            from.addLine(to: CGPoint(x: fromW, y: 0))
            from.addLine(to: CGPoint(x: fromW / 2, y: fromH / 2))
            from.close()
            let to = UIBezierPath(roundedRect: CGRect(x: fromW / 2, y: 0, width: 0, height: 0), cornerRadius: 0)
            let topLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(topLayer)
            
            let from1 = UIBezierPath()
            from1.move(to: CGPoint(x: fromW, y: 0))
            from1.addLine(to: CGPoint(x: fromW, y: fromH))
            from1.addLine(to: CGPoint(x: fromW / 2, y: fromH / 2))
            from1.close()
            let to1 = UIBezierPath(roundedRect: CGRect(x: fromW, y: fromH / 2, width: 0, height: 0), cornerRadius: 0)
            let rightLayer = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: nil)
            maskLayer.addSublayer(rightLayer)
            
            let from2 = UIBezierPath()
            from2.move(to: CGPoint(x: fromW, y: fromH))
            from2.addLine(to: CGPoint(x: 0, y: fromH))
            from2.addLine(to: CGPoint(x: fromW / 2, y: fromH / 2))
            from2.close()
            let to2 = UIBezierPath(roundedRect: CGRect(x: fromW / 2, y: fromH, width: 0, height: 0), cornerRadius: 0)
            let bottomLayer = getAnimationLayer(size: maskSize, fromPath: from2, toPath: to2, complete: nil)
            maskLayer.addSublayer(bottomLayer)
            
            let from3 = UIBezierPath()
            from3.move(to: CGPoint(x: 0, y: fromH))
            from3.addLine(to: CGPoint(x: 0, y: 0))
            from3.addLine(to: CGPoint(x: fromW / 2, y: fromH / 2))
            from3.close()
            let to3 = UIBezierPath(roundedRect: CGRect(x: 0, y: fromH / 2, width: 0, height: 0), cornerRadius: 0)
            let leftLayer = getAnimationLayer(size: maskSize, fromPath: from3, toPath: to3, complete: complete)
            maskLayer.addSublayer(leftLayer)
            break
        case .diamondVertical:
            let from = UIBezierPath()
            from.move(to: CGPoint(x: -(fromW / 2), y: -fromH))
            from.addLine(to: CGPoint(x: fromW / 2, y: -2 * fromH))
            from.addLine(to: CGPoint(x: fromW / 2 + fromW, y: -fromH))
            from.addLine(to: CGPoint(x: fromW / 2, y: 0))
            
            let to = UIBezierPath()
            to.move(to: CGPoint(x: -fromW / 2, y: fromH))
            to.addLine(to: CGPoint(x: fromW / 2, y: 0))
            to.addLine(to: CGPoint(x: fromW / 2 + fromW, y: fromH))
            to.addLine(to: CGPoint(x: fromW / 2, y: 2 * fromH))
            let topLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(topLayer)
            
            let from1 = UIBezierPath()
            from1.move(to: CGPoint(x: -fromW / 2, y: 2 * fromH))
            from1.addLine(to: CGPoint(x: fromW / 2, y: fromH))
            from1.addLine(to: CGPoint(x: fromW / 2 + fromW, y: 2 * fromH))
            from1.addLine(to: CGPoint(x: fromW / 2, y: 3 * fromH))
            
            let to1 = UIBezierPath()
            to1.move(to: CGPoint(x: -fromW / 2, y: 0))
            to1.addLine(to: CGPoint(x: fromW / 2, y: -fromH))
            to1.addLine(to: CGPoint(x: fromW / 2 + fromW, y: 0))
            to1.addLine(to: CGPoint(x: fromW / 2, y: fromH))
            let bottomLayer = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: complete)
            maskLayer.addSublayer(bottomLayer)
            break
        case .diamondHorizontal:
            let from = UIBezierPath()
            from.move(to: CGPoint(x: -2 * fromW, y: fromH / 2))
            from.addLine(to: CGPoint(x: -fromW, y: -fromH / 2))
            from.addLine(to: CGPoint(x: 0, y: fromH / 2))
            from.addLine(to: CGPoint(x: -fromW, y: fromH / 2 * 3))
            
            let to = UIBezierPath()
            to.move(to: CGPoint(x: 0, y: fromH / 2))
            to.addLine(to: CGPoint(x: fromW, y: -fromH / 2))
            to.addLine(to: CGPoint(x: 2 * fromW, y: fromH / 2))
            to.addLine(to: CGPoint(x: fromW, y: fromH / 2 * 3))
            let leftLayer = getAnimationLayer(size: maskSize, fromPath: from, toPath: to, complete: nil)
            maskLayer.addSublayer(leftLayer)
            
            let from1 = UIBezierPath()
            from1.move(to: CGPoint(x: fromW, y: fromH / 2))
            from1.addLine(to: CGPoint(x: 2 * fromW, y: -fromH / 2))
            from1.addLine(to: CGPoint(x: 3 * fromW, y: fromH / 2))
            from1.addLine(to: CGPoint(x: 2 * fromW, y: fromH / 2 * 3))
            
            let to1 = UIBezierPath()
            to1.move(to: CGPoint(x: -fromW, y: fromH / 2))
            to1.addLine(to: CGPoint(x: 0, y: -fromH / 2))
            to1.addLine(to: CGPoint(x: fromW, y: fromH / 2))
            to1.addLine(to: CGPoint(x: 0, y: fromH / 2 * 3))
            let rightLayer = getAnimationLayer(size: maskSize, fromPath: from1, toPath: to1, complete: complete)
            maskLayer.addSublayer(rightLayer)
            break
        }
        
        switch self.type {
        case .vertical, .horizontal, .leftDiagonal, .rightDiagonal, .crossDiagonal:
            fromVC.view.layer.mask = maskLayer
            break
        case .diamondVertical, .diamondHorizontal:
            toVC.view.layer.mask = maskLayer
            break
        }

    }
    
}

extension JWStackTransitionAnimationSplit {
    
    /// get animation layer
    /// - Parameters:
    ///   - size: shap layer size
    ///   - fromPath: animation fromValue
    ///   - toPath: animation toValue
    ///   - complete: animation finished call back
    func getAnimationLayer(size: CGSize, fromPath: UIBezierPath, toPath: UIBezierPath, complete: (() -> Void)? = nil) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = fromPath.cgPath
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        shapeLayer.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let animation = JWStackTransitionBasicAnimation()
        animation.keyPath = "path"
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = self.duration
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.autoreverses = false
        animation.animationFinished = complete
        shapeLayer.add(animation, forKey: "path")
        
        return shapeLayer
    }

}

#endif
