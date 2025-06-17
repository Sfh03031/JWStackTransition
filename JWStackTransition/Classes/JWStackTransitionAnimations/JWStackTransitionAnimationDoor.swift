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
    
    init(_ type: JWStackTransitionAnimationDoorType, scale: CGFloat) {
        self.type = type
        if scale > 0.0 && scale <= 1.0 {
            self.scale = scale
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
        }
    }
}

extension JWStackTransitionAnimationDoor {
    
    /// horizontal open animation
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
        } completion: { _ in
            let cancelled = transitionContext.transitionWasCancelled
            if cancelled {
                containerView.addSubview(fromView)
                self.removeOther(fromView)
            } else {
                containerView.addSubview(toView)
                self.removeOther(toView)
            }
            
            transitionContext.completeTransition(!cancelled)
        }
    }
    
    /// horizontal close animation
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
        } completion: { _ in
            // reset the transform
            fromView.transform = CGAffineTransform.identity
            let cancelled = transitionContext.transitionWasCancelled
            if cancelled {
                self.removeOther(fromView)
            } else {
                fromView.frame = containerView.bounds
                toView.frame = containerView.bounds
                self.removeOther(toView)
            }
            
            transitionContext.completeTransition(!cancelled)
        }
    }
    
    /// vertical open animation
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
        } completion: { _ in
            let cancelled = transitionContext.transitionWasCancelled
            if cancelled {
                containerView.addSubview(fromView)
                self.removeOther(fromView)
            } else {
                containerView.addSubview(toView)
                self.removeOther(toView)
            }
            
            transitionContext.completeTransition(!cancelled)
        }
    }
    
    /// vertical close animation
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
        } completion: { _ in
            // reset the transform
            fromView.transform = CGAffineTransform.identity
            let cancelled = transitionContext.transitionWasCancelled
            if cancelled {
                self.removeOther(fromView)
            } else {
                fromView.frame = containerView.bounds
                toView.frame = containerView.bounds
                self.removeOther(toView)
            }
            
            transitionContext.completeTransition(!cancelled)
        }
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
