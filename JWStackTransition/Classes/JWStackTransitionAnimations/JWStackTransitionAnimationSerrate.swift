//
//  JWStackTransitionAnimationSerrate.swift
//  Pods
//
//  Created by sfh on 2025/6/30.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationSerrate: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationSerrateType = .horizontal // animation door type
    private var count: Int = 7 // animation serrate count, if type is `horizontal`, this value default to be 7, if type is `vertical`, this value default to be 5
    
    init(_ type: JWStackTransitionAnimationSerrateType, count: Int) {
        self.type = type
        self.count = type == .horizontal ? 7 : 5
        if count > 0 {
            self.count = count
        }
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        
        var fromViewSnapshot: UIImage?
        UIGraphicsBeginImageContextWithOptions(fromView.bounds.size, true, (containerView.window?.screen.scale)!)
        fromView.drawHierarchy(in: fromView.bounds, afterScreenUpdates: false)
        fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        switch self.type {
        case .horizontal:
            let width = fromView.frame.width
            let height = fromView.frame.height
            let viewWidth = fromView.frame.width * 0.6
            let frontLayerWidth = fromView.frame.width  - viewWidth
            
            let fromView1 = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: height))
            let fromView2 = UIView(frame: CGRect(x: frontLayerWidth, y: 0, width: viewWidth, height: height))
            
            let backLayerHeight = fromView.frame.height / CGFloat(self.count)
            
            var i: Int = 0
            while i < self.count {
                let frame = CGRect(x: 0, y: CGFloat(i) * backLayerHeight, width: viewWidth, height: backLayerHeight)
                let contentFrame = CGRect(x: 0, y: -(CGFloat(i) * backLayerHeight), width: width, height: height)
                fromView1.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                i += 2
            }
            var j: Int = 1
            while j < self.count {
                let frame = CGRect(x: 0, y: CGFloat(j) * backLayerHeight, width: viewWidth, height: backLayerHeight)
                let contentFrame = CGRect(x: -(frontLayerWidth), y: -(CGFloat(j) * backLayerHeight), width: width, height: height)
                fromView2.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                j += 2
            }
            fromView1.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: 0, width: frontLayerWidth,height: height), contentsFrame: fromView.frame, contents: fromViewSnapshot!))
            fromView2.layer.addSublayer(addLayerWith(frame: CGRect(x: viewWidth - frontLayerWidth,y: 0, width: frontLayerWidth,height: height), contentsFrame:CGRect(x: -(viewWidth),y: 0, width: width,height: height) , contents: fromViewSnapshot!))
            
            let center1 = CGPoint(x: fromView1.center.x - viewWidth, y: fromView1.center.y)
            let center2 = CGPoint(x: fromView2.center.x + viewWidth, y: fromView2.center.y)
            
            containerView.addSubview(fromView1)
            containerView.addSubview(fromView2)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear]) {
                fromView1.center = center1
                fromView2.center = center2
            } completion: { finished in
                if finished {
                    if transitionContext.transitionWasCancelled {
                        containerView.addSubview(fromView)
                        self.removeOther(fromView)
                    } else {
                        containerView.addSubview(toView)
                        self.removeOther(toView)
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        case .vertical:
            let width = fromView.frame.width
            let height = fromView.frame.height
            let viewHeight = fromView.frame.height * 0.6
            let frontLayerHeight = fromView.frame.height  - viewHeight
            
            let fromView1 = UIView(frame: CGRect(x: 0, y: 0, width: width, height: viewHeight))
            let fromView2 = UIView(frame: CGRect(x: 0, y: frontLayerHeight, width: width, height: viewHeight))
            
            let backLayerWidth = fromView.frame.width / CGFloat(self.count)
            
            var i: Int = 0
            while i < self.count {
                let frame = CGRect(x: CGFloat(i) * backLayerWidth, y: 0, width: backLayerWidth, height: viewHeight)
                let contentFrame = CGRect(x: -(CGFloat(i) * backLayerWidth), y: 0, width: width, height: height)
                fromView1.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                i += 2
            }
            
            var j: Int = 1
            while j < self.count {
                let frame = CGRect(x: CGFloat(j) * backLayerWidth, y: 0, width: backLayerWidth, height: viewHeight)
                let contentFrame = CGRect(x: -(CGFloat(j) * backLayerWidth), y: -(frontLayerHeight), width: width, height: height)
                fromView2.layer.addSublayer(addLayerWith(frame: frame, contentsFrame: contentFrame, contents: fromViewSnapshot!))
                j += 2
            }
            fromView1.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: 0, width: width,height: frontLayerHeight), contentsFrame: fromView.frame, contents: fromViewSnapshot!))
            fromView2.layer.addSublayer(addLayerWith(frame: CGRect(x: 0,y: viewHeight - frontLayerHeight, width: width, height: frontLayerHeight), contentsFrame:CGRect(x: 0,y: -(viewHeight), width: width,height: height) , contents: fromViewSnapshot!))
            
            let center1 = CGPoint(x: fromView1.center.x, y: fromView1.center.y - viewHeight)
            let center2 = CGPoint(x: fromView2.center.x, y: fromView2.center.y + viewHeight)
            
            containerView.addSubview(fromView1)
            containerView.addSubview(fromView2)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear]) {
                fromView1.center = center1
                fromView2.center = center2
            } completion: { finished in
                if finished {
                    if transitionContext.transitionWasCancelled {
                        containerView.addSubview(fromView)
                        self.removeOther(fromView)
                    } else {
                        containerView.addSubview(toView)
                        self.removeOther(toView)
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }
    }
}

extension JWStackTransitionAnimationSerrate {
    
    /// add layer
    /// - Parameters:
    ///   - frame: layer frame
    ///   - contents: layer contents
    /// - Returns: CALayer
    func addLayerWith(frame: CGRect, contents: UIImage) -> CALayer {
        let layer = CALayer()
        layer.frame = frame
        layer.rasterizationScale = contents.scale
        layer.masksToBounds = true
        layer.isDoubleSided = false
        layer.contents = contents.cgImage
        return layer
    }
    
    /// add layer
    /// - Parameters:
    ///   - frame: layer frame
    ///   - contentsFrame: layer frame
    ///   - contents: layer contents
    /// - Returns: CALayer
    func addLayerWith(frame: CGRect, contentsFrame: CGRect, contents: UIImage) -> CALayer {
        let contentLayer = CALayer()
        contentLayer.frame = contentsFrame
        contentLayer.rasterizationScale = contents.scale
        contentLayer.masksToBounds = true
        contentLayer.isDoubleSided = false
        contentLayer.contents = contents.cgImage
        
        let layer = CALayer()
        layer.frame = frame
        layer.rasterizationScale = contents.scale
        layer.masksToBounds = true
        layer.isDoubleSided = false
        layer.addSublayer(contentLayer)
        
        return layer
    }

    /// remove all the views other than the given view from the superview
    /// - Parameter target: the given view
    func removeOther(_ target: UIView) {
        let containerView = target.superview!
        for view in containerView.subviews {
            if view != target {
                view.removeFromSuperview()
            }
        }
    }
    
}

#endif
