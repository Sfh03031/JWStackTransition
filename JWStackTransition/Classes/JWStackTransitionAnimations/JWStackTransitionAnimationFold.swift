//
//  JWStackTransitionAnimationFold.swift
//  Pods
//
//  Created by sfh on 2025/6/13.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationFold: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationFoldType = .fromLeftToRight // animation fold direction type
    private var foldNum: Int = 2 // animation fold number
    
    public init(_ type: JWStackTransitionAnimationFoldType, foldNum: Int) {
        self.type = type
        self.foldNum = foldNum
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
              let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        // final frame of toView
        toView.frame = transitionContext.finalFrame(for: toVC)
        // TODO: toView rect move offset, set 2.0 times the height offscreen
        toView.frame = CGRectOffset(toView.frame, 0, 2.0 * toView.frame.height)
        containerView.addSubview(toView)
        
        // add a perspective transform
        var transform = CATransform3DIdentity
        transform.m34 = -0.005
        containerView.layer.sublayerTransform = transform
        
        let size = toView.frame.size
        let foldW = size.width * 0.5 / CGFloat(self.foldNum)
        
        // arrays that hold the snapshot views
        var fromFoldList: [UIView] = []
        var toFoldList: [UIView] = []
        
        // create the folds for the form- and to- views
        for i in 0..<self.foldNum {
            let offset = CGFloat(i) * foldW * 2
            
            // the left and right side of the fold for the fromView, with identity transform and 0.0 alpha
            // on the shadow, with each view at its initial position
            let leftFromView = self.creatShot(fromView, afterUpdate: false, offset: offset, left: true)
            leftFromView.layer.position = CGPoint(x: offset, y: size.height / 2)
            fromFoldList.append(leftFromView)
            leftFromView.subviews[1].alpha = 0.0
            
            let rightFromView = self.creatShot(fromView, afterUpdate: false, offset: offset + foldW, left: false)
            rightFromView.layer.position = CGPoint(x: offset + foldW * 2, y: size.height / 2)
            fromFoldList.append(rightFromView)
            rightFromView.subviews[1].alpha = 0.0
            
            // the left and right side of the fold for the toView, with a 90-degree transform and 1.0 alpha
            // on the shadow, with each view positioned at the very edge of the screen
            let leftToView = self.creatShot(toView, afterUpdate: true, offset: offset, left: true)
            leftToView.layer.position = CGPoint(x: self.type == .fromRightToLeft ? size.width : 0.0, y: size.height / 2)
            leftToView.layer.transform = CATransform3DMakeRotation(0.5 * .pi, 0.0, 1.0, 0.0)
            toFoldList.append(leftToView)
            
            let rightToView = self.creatShot(toView, afterUpdate: true, offset: offset + foldW, left: false)
            rightToView.layer.position = CGPoint(x: self.type == .fromRightToLeft ? size.width : 0.0, y: size.height / 2)
            rightToView.layer.transform = CATransform3DMakeRotation(-0.5 * .pi, 0.0, 1.0, 0.0)
            toFoldList.append(rightToView)
        }
        
        // move the fromView off screen
        fromView.frame = CGRectOffset(fromView.frame, -2.0 * fromView.frame.width, 0)
        
        // create the animation, set the final state for each fold
        UIView.animate(withDuration: duration) {
            for i in 0..<self.foldNum {
                let offset = CGFloat(i) * foldW * 2
                
                // the left and right side of the fold for the from- view, with 90 degree transform and 1.0 alpha
                // on the shadow, with each view positioned at the edge of thw screen.
                let leftFromView = fromFoldList[i * 2]
                leftFromView.layer.position = CGPoint(x: self.type == .fromRightToLeft ? 0.0 : size.width, y: size.height / 2)
                leftFromView.layer.transform = CATransform3DRotate(transform, 0.5 * .pi, 0.0, 1.0, 0.0)
                leftFromView.subviews[1].alpha = 1.0
                
                let rightFromView = fromFoldList[i * 2 + 1]
                rightFromView.layer.position = CGPoint(x: self.type == .fromRightToLeft ? 0.0 : size.width, y: size.height / 2)
                rightFromView.layer.transform = CATransform3DRotate(transform, -0.5 * .pi, 0.0, 1.0, 0.0)
                rightFromView.subviews[1].alpha = 1.0
                
                // the left and right side of the fold for the to- view, with identity transform and 0.0 alpha
                // on the shadow, with each view at its final position
                let leftToView = toFoldList[i * 2]
                leftToView.layer.position = CGPoint(x: offset, y: size.height / 2)
                leftToView.layer.transform = CATransform3DIdentity
                leftToView.subviews[1].alpha = 0.0
                
                let rightToView = toFoldList[i * 2 + 1]
                rightToView.layer.position = CGPoint(x: offset + foldW * 2, y: size.height / 2)
                rightToView.layer.transform = CATransform3DIdentity
                rightToView.subviews[1].alpha = 0.0
            }
        } completion: { _ in
            // remove the snapshot views
            for view in toFoldList {
                view.removeFromSuperview()
            }
            
            for view in fromFoldList {
                view.removeFromSuperview()
            }
            
            let finished = !transitionContext.transitionWasCancelled
            if finished {
                // restore the to- and from- to the initial location
                toView.frame = containerView.bounds
                fromView.frame = containerView.bounds
            } else {
                // restore the from- to the initial location if cancelled
                fromView.frame = containerView.bounds
            }
            
            transitionContext.completeTransition(finished)
        }

    }

}

extension JWStackTransitionAnimationFold {
    
    /// creates a snapshot for the gives view
    /// - Parameters:
    ///   - view: the gives view
    ///   - afterUpdate: whether after screen updates or not
    ///   - offset: offset
    ///   - left: whether left or not
    /// - Returns: a new view
    func creatShot(_ view: UIView, afterUpdate: Bool, offset: CGFloat, left: Bool) -> UIView {
        let size = view.frame.size
        let containerView = view.superview!
        let foldW = size.width * 0.5 / CGFloat(self.foldNum)
        
        let regin = CGRectMake(offset, 0.0, foldW, size.height)
        
        var shotView = UIView()
        if !afterUpdate {
            // create a regular snapshot
            shotView = view.resizableSnapshotView(from: regin, afterScreenUpdates: afterUpdate, withCapInsets: .zero)!
        } else {
            // for the to- view for some reason the snapshot takes a while to create. Here we place the snapshot within
            // another view, with the same bckground color, so that it is less noticeable when the snapshot initially renders
            shotView = UIView.init(frame: CGRectMake(0, 0, foldW, size.height))
            shotView.backgroundColor = view.backgroundColor
            let subView = view.resizableSnapshotView(from: regin, afterScreenUpdates: afterUpdate, withCapInsets: .zero)!
            shotView.addSubview(subView)
        }
        
        // create a shadow
        let shadowView = self.addGradient(shotView, reverse: left)
        // add to the container
        containerView.addSubview(shadowView)
        // set the anchor to the left or right edge of the view
        shadowView.layer.anchorPoint = CGPoint(x: left ? 0.0 : 1.0, y: 0.5)
        
        return shadowView
    }
    
    /// add gradient
    /// - Parameters:
    ///   - toView: the gives view
    ///   - reverse: whether reverse or not
    /// - Returns: a new view
    func addGradient(_ toView: UIView, reverse: Bool) -> UIView {
        // create a view with the same frame
        let targetView = UIView(frame: toView.frame)
        // create a shadow
        let shadowView = UIView(frame: targetView.bounds)
        
        let colors = [UIColor(white: 0.0, alpha: 0.0).cgColor, UIColor(white: 0.0, alpha: 1.0).cgColor]
        let start = reverse ? CGPoint(x: 0.0, y: 0.2) : CGPoint(x: 1.0, y: 0.0)
        let end = reverse ? CGPoint(x: 1.0, y: 0.0) : CGPoint(x: 0.0, y: 1.0)
        shadowView.makeGradient(colors, locations: [0.0, 1.0], start: start, end: end)
        // add the original view into our new view
        toView.frame = toView.bounds
        targetView.addSubview(toView)
        // place the shadow on top
        targetView.addSubview(shadowView)
        
        return targetView
    }
    
}

#endif
