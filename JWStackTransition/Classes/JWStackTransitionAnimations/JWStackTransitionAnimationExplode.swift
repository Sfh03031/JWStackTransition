//
//  JWStackTransitionAnimationExplode.swift
//  Pods
//
//  Created by sfh on 2025/6/16.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationExplode: JWStackTransitionAnimationDelegate {
    
    private var explodePieceWidth: CGFloat = 50.0 // explode pice width
    
    init(_ explodePieceWidth: CGFloat) {
        self.explodePieceWidth = explodePieceWidth
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        // add the toView to the container
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.sendSubviewToBack(toView)
        
        let size = toView.frame.size
        
        var tempList: [UIView] = []
        
        let factorW = self.explodePieceWidth
        let factorH = factorW * size.height / size.width
        
        let fromShot = fromView.snapshotView(afterScreenUpdates: false) ?? UIView()
        
        let columnNum = Int(ceil(size.width / factorW))
        let rowNum = Int(ceil(size.height / factorH))
        for i in 0..<columnNum {
            for j in 0..<rowNum {
                let rect = CGRect(x: CGFloat(i) * factorW, y: CGFloat(j) * factorH, width: factorW, height: factorH)
                // FIXME: Snapshotting a view (0x126cf1680, _UIReplicantView) that has not been rendered at least once requires afterScreenUpdates:YES
                if let shot = fromShot.resizableSnapshotView(from: rect, afterScreenUpdates: false, withCapInsets: .zero) {
                    shot.frame = rect
                    containerView.addSubview(shot)
                    tempList.append(shot)
                }
            }
        }
        
        containerView.sendSubviewToBack(fromView)
        
        UIView.animate(withDuration: duration) {
            for view in tempList {
                let offsetX = self.randomBetween(small: -100.0, big: 100.0)
                let offsetY = self.randomBetween(small: -100.0, big: 100.0)
                view.frame = CGRectOffset(view.frame, CGFloat(offsetX), CGFloat(offsetY))
                view.alpha = 0.0
                
                let offsetR = self.randomBetween(small: -10.0, big: 10.0)
                let rotation = CGAffineTransformMakeRotation(CGFloat(offsetR))
                view.transform = CGAffineTransformScale(rotation, 0.01, 0.01)
            }
        } completion: { _ in
            for view in tempList {
                view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }

}

extension JWStackTransitionAnimationExplode {
    
    func randomBetween(small: Float, big: Float) -> Float {
        let diff = big - small
        let a = Float(arc4random())
        let b = Float(UInt16.max)
        return ((a.truncatingRemainder(dividingBy: (b + 1))) / b) * diff + small
    }
    
}

#endif
