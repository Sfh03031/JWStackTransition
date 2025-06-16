//
//  JWStackTransitionAnimationDoor.swift
//  Pods
//
//  Created by sfh on 2025/6/16.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationDoor: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationDoorType = .open // animation type case of JWStackTransitionAnimationDoorType
    
    init(_ type: JWStackTransitionAnimationDoorType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        if self.type == .open {
            // add the scaled toView to the container
            let toViewShot = toView.resizableSnapshotView(from: toView.frame, afterScreenUpdates: true, withCapInsets: .zero) ?? UIView()
            let scale = CATransform3DIdentity
            toViewShot.layer.transform = CATransform3DScale(scale, 0.8, 0.8, 1.0)
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

        } else {
            containerView.addSubview(fromView)
            
            // add the toView and send offscreen, in order to allow snapshotting
            toView.frame = transitionContext.finalFrame(for: toVC)
            toView.frame = CGRectOffset(toView.frame, 2.0 * toView.frame.width, 0) // set 2.0 times the width offscreen
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
                fromView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
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
