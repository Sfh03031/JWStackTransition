//
//  JWStackTransitionAnimationDoor.swift
//  Pods
//
//  Created by sfh on 2025/6/16.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationDoor: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationDoorType = .horizontalOpen // animation door type
    private var scale: CGFloat = 0.8 // animation scale, (0.0, 1.0]
    
    private var transitionView: UIView?
    private var secondView: UIView?
    
    init(_ type: JWStackTransitionAnimationDoorType, scale: CGFloat?) {
        self.type = type
        if scale != nil {
            if scale! > 0.0 && scale! <= 1.0 {
                self.scale = scale!
            }
        }
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        switch self.type {
        case .horizontalOpen:
            self.horizontalOpen(fromView, toView: toView, duration: duration, transitionContext: transitionContext)
        case .horizontalClose:
            self.horizontalClose(fromView, toView: toView, toVC: toVC, duration: duration, transitionContext: transitionContext)
        case .verticalOpen:
            self.verticalOpen(fromView, toView: toView, duration: duration, transitionContext: transitionContext)
        case .verticalClose:
            self.verticalClose(fromView, toView: toView, toVC: toVC, duration: duration, transitionContext: transitionContext)
        case .horizontal, .vertical:
            let containerView = transitionContext.containerView
            
            var fromViewSnapshot: UIImage?
            var toViewSnapshot: UIImage?
            
            containerView.addSubview(toView)
            secondView = toView
            
            UIGraphicsBeginImageContextWithOptions(fromView.bounds.size, true, (containerView.window?.screen.scale)!)
            fromView.drawHierarchy(in: fromView.bounds, afterScreenUpdates: false)
            fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                UIGraphicsBeginImageContextWithOptions(toView.bounds.size, true, (containerView.window?.screen.scale)!)
                toView.drawHierarchy(in: toView.bounds, afterScreenUpdates: false)
                toViewSnapshot = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            
            let transitionView = UIView(frame: containerView.bounds)
            transitionView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
            containerView.addSubview(transitionView)
            
            let transitionContainer = UIView(frame: containerView.bounds)
            transitionView.addSubview(transitionContainer)
            self.transitionView = transitionView

            var t = CATransform3DIdentity
            t.m34 = -1.0 / (transitionContainer.bounds.size.height * 2.0)
            transitionContainer.layer.transform = t
            
            let fromContentLayer1 = CALayer()
            fromContentLayer1.frame = fromView.frame
            fromContentLayer1.rasterizationScale = (fromViewSnapshot?.scale)!
            fromContentLayer1.masksToBounds = true
            fromContentLayer1.isDoubleSided = false
            fromContentLayer1.contents = fromViewSnapshot?.cgImage
            
            let fromContentLayer2 = CALayer()
            fromContentLayer2.frame = fromView.frame
            fromContentLayer2.rasterizationScale = (fromViewSnapshot?.scale)!
            fromContentLayer2.masksToBounds = true
            fromContentLayer2.isDoubleSided = false
            fromContentLayer2.contents = fromViewSnapshot?.cgImage
            
            let toContentLayer = CALayer()
            toContentLayer.frame = fromView.frame
            DispatchQueue.main.async {
                let wereActiondDisabled = CATransaction.disableActions()
                CATransaction.setDisableActions(true)
                toContentLayer.rasterizationScale = (toViewSnapshot?.scale)!
                toContentLayer.masksToBounds = true
                toContentLayer.isDoubleSided = false
                toContentLayer.contents = toViewSnapshot?.cgImage
                CATransaction.setDisableActions(wereActiondDisabled)
            }
            
            setupTranisition(mainLayer: transitionContainer.layer, fromLayer1: fromContentLayer1, fromLayer2: fromContentLayer2, toLayer: toContentLayer, fromView: fromView, toView: toView, duration: duration, transitionContext: transitionContext)
        }
    }
}

//MARK: vertical open animation
extension JWStackTransitionAnimationDoor {
    
    func verticalOpen(_ fromView: UIView, toView: UIView, duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        // add the scaled toView to the container
        let toViewShot = toView.resizableSnapshotView(from: toView.frame, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
        let scale = CATransform3DIdentity
        toViewShot.layer.transform = CATransform3DScale(scale, self.scale, self.scale, 1.0)
        containerView.addSubview(toViewShot)
        containerView.sendSubviewToBack(toViewShot)
        
        // add top door view to the container
        let topRect = CGRect(x: 0, y: 0, width: fromView.frame.width, height: fromView.frame.height / 2)
        let topDoorView = fromView.resizableSnapshotView(from: topRect, afterScreenUpdates: false, withCapInsets: .zero) ?? UIView()
        topDoorView.frame = topRect
        containerView.addSubview(topDoorView)
        
        // add bottom door view to the container
        let bottomRect = CGRect(x: 0, y: fromView.frame.height / 2, width: fromView.frame.width, height: fromView.frame.height / 2)
        let bottomDoorView = fromView.resizableSnapshotView(from: bottomRect, afterScreenUpdates: false, withCapInsets: .zero) ?? UIView()
        bottomDoorView.frame = bottomRect
        containerView.addSubview(bottomDoorView)
        
        fromView.removeFromSuperview()
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut) {
            // open the doors
            topDoorView.frame = CGRectOffset(topDoorView.frame, 0,  -topDoorView.frame.height)
            bottomDoorView.frame = CGRectOffset(bottomDoorView.frame, 0, bottomDoorView.frame.height)
            // zoom in
            toViewShot.center = toView.center
            toViewShot.frame = toView.frame
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

//MARK: vertical close animation
extension JWStackTransitionAnimationDoor {
    
    func verticalClose(_ fromView: UIView, toView: UIView, toVC: UIViewController, duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromView)
        
        // add the toView and send offscreen, in order to allow snapshotting
        toView.frame = transitionContext.finalFrame(for: toVC)
        // TODO: set 1.0 times the height offscreen
        toView.frame = CGRectOffset(toView.frame, 0, toView.frame.height)
        containerView.addSubview(toView)
        
        // add top door view to the container
        let topRect = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height / 2)
        let topDoorView = toView.resizableSnapshotView(from: topRect, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
        topDoorView.frame = topRect
        topDoorView.frame = CGRectOffset(topDoorView.frame, 0, -topDoorView.frame.height)
        containerView.addSubview(topDoorView)
        
        // add bottom door view to the container
        let bottomRect = CGRect(x: 0, y: toView.frame.height / 2, width: toView.frame.width, height: toView.frame.height / 2)
        let bottomDoorView = toView.resizableSnapshotView(from: bottomRect, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
        bottomDoorView.frame = bottomRect
        bottomDoorView.frame = CGRectOffset(bottomDoorView.frame, 0, bottomDoorView.frame.height)
        containerView.addSubview(bottomDoorView)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut) {
            // close the doors
            topDoorView.frame = CGRectOffset(topDoorView.frame, 0, topDoorView.frame.height)
            bottomDoorView.frame = CGRectOffset(bottomDoorView.frame, 0, -bottomDoorView.frame.height)
            
            // zoom out
            fromView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
        } completion: { finished in
            if finished {
                // reset the transform
                fromView.transform = CGAffineTransform.identity
                if transitionContext.transitionWasCancelled {
                    self.removeOther(fromView)
                } else {
                    fromView.frame = containerView.bounds
                    toView.frame = containerView.bounds
                    self.removeOther(toView)
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

//MARK: horizontal open animation
extension JWStackTransitionAnimationDoor {
    
    func horizontalOpen(_ fromView: UIView, toView: UIView, duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        // add the scaled toView to the container
        let toViewShot = toView.resizableSnapshotView(from: toView.frame, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
        let scale = CATransform3DIdentity
        toViewShot.layer.transform = CATransform3DScale(scale, self.scale, self.scale, 1.0)
        containerView.addSubview(toViewShot)
        containerView.sendSubviewToBack(toViewShot)
        
        // add left door view to the container
        let leftRect = CGRect(x: 0, y: 0, width: fromView.frame.width / 2, height: fromView.frame.height)
        let leftDoorView = fromView.resizableSnapshotView(from: leftRect, afterScreenUpdates: false, withCapInsets: .zero) ?? UIView()
        leftDoorView.frame = leftRect
        containerView.addSubview(leftDoorView)
        
        // add right door view to the container
        let rightRect = CGRect(x: fromView.frame.width / 2, y: 0, width: fromView.frame.width / 2, height: fromView.frame.height)
        let rightDoorView = fromView.resizableSnapshotView(from: rightRect, afterScreenUpdates: false, withCapInsets: .zero) ?? UIView()
        rightDoorView.frame = rightRect
        containerView.addSubview(rightDoorView)
        
        fromView.removeFromSuperview()
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut) {
            // open the doors
            leftDoorView.frame = CGRectOffset(leftDoorView.frame, -leftDoorView.frame.width, 0)
            rightDoorView.frame = CGRectOffset(rightDoorView.frame, rightDoorView.frame.width, 0)
            // zoom in
            toViewShot.center = toView.center
            toViewShot.frame = toView.frame
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

//MARK: horizontal close animation
extension JWStackTransitionAnimationDoor {
    
    func horizontalClose(_ fromView: UIView, toView: UIView, toVC: UIViewController, duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromView)
        
        // add the toView and send offscreen, in order to allow snapshotting
        toView.frame = transitionContext.finalFrame(for: toVC)
        // TODO: set -2.0 times the width offscreen
        toView.frame = CGRectOffset(toView.frame, -2.0 * toView.frame.width, 0)
        containerView.addSubview(toView)
        
        // add left door view to the container
        let leftRect = CGRect(x: 0, y: 0, width: toView.frame.width / 2, height: toView.frame.height)
        let leftDoorView = toView.resizableSnapshotView(from: leftRect, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
        leftDoorView.frame = leftRect
        leftDoorView.frame = CGRectOffset(leftDoorView.frame, -leftDoorView.frame.width, 0)
        containerView.addSubview(leftDoorView)
        
        // add right door view to the container
        let rightRect = CGRect(x: toView.frame.width / 2, y: 0, width: toView.frame.width / 2, height: toView.frame.height)
        let rightDoorView = toView.resizableSnapshotView(from: rightRect, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
        rightDoorView.frame = rightRect
        rightDoorView.frame = CGRectOffset(rightDoorView.frame, rightDoorView.frame.width, 0)
        containerView.addSubview(rightDoorView)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut) {
            // close the doors
            leftDoorView.frame = CGRectOffset(leftDoorView.frame, leftDoorView.frame.width, 0)
            rightDoorView.frame = CGRectOffset(rightDoorView.frame, -rightDoorView.frame.width, 0)
            
            // zoom out
            fromView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
        } completion: { finished in
            if finished {
                fromView.transform = CGAffineTransform.identity
                if transitionContext.transitionWasCancelled {
                    self.removeOther(fromView)
                } else {
                    fromView.frame = containerView.bounds
                    toView.frame = containerView.bounds
                    self.removeOther(toView)
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            
        }
    }
}

extension JWStackTransitionAnimationDoor {
    
    func setupTranisition(mainLayer: CALayer, fromLayer1: CALayer, fromLayer2: CALayer, toLayer: CALayer, fromView: UIView, toView: UIView, duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        
        var t = CATransform3DIdentity
        t.m34 = 1.0 / -900.0
        mainLayer.sublayerTransform = t
        
        let fromLayerFrame = fromView.frame
        
        let frontLayer1 = CALayer()
        frontLayer1.frame = fromLayerFrame
        frontLayer1.rasterizationScale = fromLayer1.rasterizationScale
        frontLayer1.masksToBounds = true
        frontLayer1.isDoubleSided = false
        frontLayer1.addSublayer(fromLayer1)
        
        let frontLayer2 = CALayer()
        frontLayer2.frame = fromLayerFrame
        frontLayer2.rasterizationScale = fromLayer2.rasterizationScale
        frontLayer2.masksToBounds = true
        frontLayer2.isDoubleSided = false
        frontLayer2.addSublayer(fromLayer2)
        
        mainLayer.addSublayer(toLayer)
        mainLayer.addSublayer(frontLayer1)
        mainLayer.addSublayer(frontLayer2)
        
        var anchorPoint1 = CGPoint.zero
        var anchorPoint2 = CGPoint.zero
        
        let width = fromLayerFrame.width
        let height = fromLayerFrame.height
        let halfWidth = width / 2.0
        let halfHeight = height / 2.0
        
        // horizontal, vertical
        var angle1 = -Double.pi / 2
        var angle2 = Double.pi / 2
        var frontLayerTransform1 = CATransform3DIdentity
        var frontLayerTransform2 = CATransform3DIdentity
        
        switch self.type {
        case .horizontal:
            frontLayer1.frame = CGRect(x: 0, y: 0, width: halfWidth, height: height)
            frontLayer2.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: height)
            fromLayer2.frame = CGRect(x: -halfWidth, y: 0, width: width, height: height)
            anchorPoint1 = CGPoint.init(x: 0, y: 0.5)
            anchorPoint2 = CGPoint.init(x: 1, y: 0.5)
            angle1 = -Double.pi / 2
            angle2 = Double.pi / 2
            frontLayerTransform1 = CATransform3DMakeRotation(CGFloat(angle1), 0, 1, 0)
            frontLayerTransform2 = CATransform3DMakeRotation(CGFloat(angle2), 0, 1, 0)
        case .vertical:
            frontLayer1.frame = CGRect(x: 0, y: 0, width: width, height: halfHeight)
            frontLayer2.frame = CGRect(x: 0, y: halfHeight, width: width, height: halfHeight)
            fromLayer2.frame = CGRect(x: 0, y: -halfHeight, width: width, height: height)
            anchorPoint1 = CGPoint.init(x: 0.5, y: 0)
            anchorPoint2 = CGPoint.init(x: 0.5, y: 1)
            angle1 = Double.pi / 2
            angle2 = -Double.pi / 2
            frontLayerTransform1 = CATransform3DMakeRotation(CGFloat(angle1), 1, 0, 0)
            frontLayerTransform2 = CATransform3DMakeRotation(CGFloat(angle2), 1, 0, 0)
        default: break
        }
        
        let wereActiondDisabled = CATransaction.disableActions()
        CATransaction.setDisableActions(true)
        
        let frame1 = frontLayer1.frame
        frontLayer1.anchorPoint = anchorPoint1
        frontLayer1.frame = frame1
        
        let frame2 = frontLayer2.frame
        frontLayer2.anchorPoint = anchorPoint2
        frontLayer2.frame = frame2
        CATransaction.setDisableActions(wereActiondDisabled)
        
        // Main Layer Animation
        let transform0 = mainLayer.transform
        let transform1 = CATransform3DTranslate(transform0, 0, 0, -200)
        
        let mainLayerTranslateAnimation = CAKeyframeAnimation(keyPath: "transform")
        mainLayerTranslateAnimation.beginTime = 0.0
        mainLayerTranslateAnimation.duration = duration
        mainLayerTranslateAnimation.isAdditive = true
        mainLayerTranslateAnimation.keyTimes = [0, 0.5, 1]
        mainLayerTranslateAnimation.values = [
            NSValue(caTransform3D: transform0),
            NSValue(caTransform3D:transform1),
            NSValue(caTransform3D:transform0)
        ]
        
        // From Layer Animation
        let frontLayerRotationAnimation1 = CABasicAnimation(keyPath: "transform")
        frontLayerRotationAnimation1.fromValue = frontLayer1.transform
        
        frontLayerRotationAnimation1.beginTime = 0
        frontLayerRotationAnimation1.duration = duration
        frontLayerRotationAnimation1.toValue = frontLayerTransform1
        frontLayer1.transform = frontLayerTransform1
        
        // To Layer Animation
        let frontLayerRotationAnimation2 = CABasicAnimation(keyPath: "transform")
        frontLayerRotationAnimation2.fromValue = frontLayer2.transform
        frontLayerRotationAnimation2.beginTime = 0
        frontLayerRotationAnimation2.duration = duration
        frontLayerRotationAnimation2.toValue = frontLayerTransform2
        frontLayer2.transform = frontLayerTransform2
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear]) {
            self.transitionView?.backgroundColor = .black
            mainLayer.add(mainLayerTranslateAnimation, forKey: nil)
            frontLayer1.add(frontLayerRotationAnimation1, forKey: nil)
            frontLayer2.add(frontLayerRotationAnimation2, forKey: nil)
        } completion: { finished in
            if finished {
                mainLayer.transform = CATransform3DIdentity
                frontLayer1.transform = CATransform3DIdentity
                frontLayer2.transform = CATransform3DIdentity
                if transitionContext.transitionWasCancelled {
                    self.removeOther(fromView)
                } else {
                    self.removeOther(toView)
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
    }
}

extension JWStackTransitionAnimationDoor {

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
