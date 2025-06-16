//
//  JWStackTransitionAnimationFlip.swift
//  Pods
//
//  Created by sfh on 2025/6/13.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationFlip: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationFoldDirectionType = .fromLeftToRight // animation fold direction type
    
    public init(_ type: JWStackTransitionAnimationFoldDirectionType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let fromVC = transitionContext.viewController(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        // add the toView to the container
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.sendSubviewToBack(toView)
        
        // add a perspective transform
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
        
        let initialFrame = transitionContext.initialFrame(for: fromVC)
        fromView.frame = initialFrame
        toView.frame = initialFrame
        
        // create two-part snapshots of both the from- and to- views
        let fromShotList = self.creatShot(fromView, afterUpdate: false)
        let toShotList = self.creatShot(toView, afterUpdate: true)
        
        var fromFlipView = fromShotList[self.type == .fromRightToLeft ? 1 : 0]
        var toFlipView = toShotList[self.type == .fromRightToLeft ? 0 : 1]
        
        // replace the from- and to- views with container views that include gradients
        fromFlipView = self.addGradient(fromFlipView, reverse: self.type != .fromRightToLeft)
        let fromFlipGradientView = fromFlipView.subviews[1]
        fromFlipGradientView.alpha = 0.0
        
        toFlipView = self.addGradient(toFlipView, reverse: self.type == .fromRightToLeft)
        let toFlipGradientView = toFlipView.subviews[1]
        toFlipGradientView.alpha = 1.0
        
        // change the anchor point so that the view rotate around the correct edge
        self.updateAnchorAndOffset(CGPoint(x: self.type == .fromRightToLeft ? 0.0 : 1.0, y: 0.5), target: fromFlipView)
        self.updateAnchorAndOffset(CGPoint(x: self.type == .fromRightToLeft ? 1.0 : 0.0, y: 0.5), target: toFlipView)
        
        // rotate the to- view by 90 degrees, hiding it
        toFlipView.layer.transform = self.rotate(self.type == .fromRightToLeft ? 0.5 * .pi : -0.5 * .pi)
        
        // animate
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: []) {
            // rotate the from- view to 90 degrees
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                fromFlipView.layer.transform = self.rotate(self.type == .fromRightToLeft ? -0.5 * .pi : 0.5 * .pi)
                fromFlipGradientView.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                toFlipView.layer.transform = self.rotate(self.type == .fromRightToLeft ? 0.001 : -0.001)
                toFlipGradientView.alpha = 0.0
            }
        } completion: { _ in
            if transitionContext.transitionWasCancelled {
                self.removeOther(fromView)
            } else {
                self.removeOther(toView)
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }

}

extension JWStackTransitionAnimationFlip {
    
    /// creates a snapshot for the gives view
    /// - Parameters:
    ///   - view: the gives view
    ///   - afterUpdate: whether after screen updates or not
    /// - Returns: a new view
    func creatShot(_ view: UIView, afterUpdate: Bool) -> [UIView] {
        let containerView = view.superview!
        let size = view.frame.size
        
        // snapshot the left-hand side of the view
        let leftRegin = CGRectMake(0, 0, size.width / 2, size.height)
        let leftView = view.resizableSnapshotView(from: leftRegin, afterScreenUpdates: afterUpdate, withCapInsets: .zero) ?? UIView()
        leftView.frame = leftRegin
        containerView.addSubview(leftView)
        
        
        // snapshot the right-hand side of the view
        let rightRegin = CGRectMake(size.width / 2, 0, size.width / 2, size.height)
        let rightView = view.resizableSnapshotView(from: rightRegin, afterScreenUpdates: afterUpdate, withCapInsets: .zero) ?? UIView()
        rightView.frame = rightRegin
        containerView.addSubview(rightView)
        
        // send the view that was snapshotted to the back
        containerView.sendSubviewToBack(view)
        
        return [leftView, rightView]
    }
    
    /// update anchor and offset
    /// - Parameters:
    ///   - anchor: anchor point
    ///   - target: target view
    func updateAnchorAndOffset(_ anchor: CGPoint, target: UIView) {
        target.layer.anchorPoint = anchor
        let offsetX = anchor.x - 0.5
        target.frame = CGRectOffset(target.frame, target.frame.width * offsetX, 0)
    }
    
    /// rotate
    /// - Parameter angle: angle
    /// - Returns: CATransform3D
    func rotate(_ angle: CGFloat) -> CATransform3D {
        return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0)
    }
    
    /// add gradient
    /// - Parameters:
    ///   - toView: the gives view
    ///   - reverse: whether reverse or not
    /// - Returns: a new view
    func addGradient(_ toView: UIView, reverse: Bool) -> UIView {
        let containerView = toView.superview!
        
        // create a view with the same frame
        let replaceView = UIView(frame: toView.frame)
        
        // replace the view that we are adding a gradient to
        containerView.insertSubview(replaceView, aboveSubview: toView)
        toView.removeFromSuperview()
        
        // create a gradient
        let gradientView = UIView(frame: replaceView.bounds)
        
        let colors = [UIColor(white: 0.0, alpha: 0.0).cgColor, UIColor(white: 0.0, alpha: 0.5).cgColor]
        let start = CGPoint(x: reverse ? 0.0 : 1.0, y: 0.0)
        let end = CGPoint(x: reverse ? 1.0 : 0.0, y: 0.0)
        gradientView.makeGradient(colors, locations: [0.0, 1.0], start: start, end: end)
        
        // add the original view into our new view
        toView.frame = toView.bounds
        replaceView.addSubview(toView)
        
        // place the gradient on top
        replaceView.addSubview(gradientView)
        
        return replaceView
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
