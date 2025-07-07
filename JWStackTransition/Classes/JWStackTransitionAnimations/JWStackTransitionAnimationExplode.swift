//
//  JWStackTransitionAnimationExplode.swift
//  Pods
//
//  Created by sfh on 2025/6/16.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationExplode: JWStackTransitionAnimationDelegate {
    
    private var explodePieceSize: CGSize = CGSize(width: 50, height: 100) // explode pice size
    
    init(_ explodeSize: CGSize) {
        self.explodePieceSize = explodeSize
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to),
              let fromShot = fromView.viewShot() else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let tempView = UIView(frame: containerView.bounds)
        containerView.addSubview(tempView)
        
        let columnNum = Int(ceil(fromView.frame.width / self.explodePieceSize.width))
        let rowNum = Int(ceil(fromView.frame.height / self.explodePieceSize.height))
        for i in 0..<columnNum {
            for j in 0..<rowNum {
                let x = self.explodePieceSize.width * CGFloat(i)
                let y = self.explodePieceSize.height * CGFloat(j)
                
                let tiledRect = CGRect(x: x, y: y, width: self.explodePieceSize.width, height: self.explodePieceSize.height)
                
                guard let fromCGImg = fromShot.cgImage,
                      let fromImgRef = fromCGImg.cropping(to: CGRect(x: fromShot.scale * tiledRect.origin.x, y: fromShot.scale * tiledRect.origin.y, width: fromShot.scale * tiledRect.width, height: fromShot.scale * tiledRect.height)) else {
                    print("cropping image failed")
                    return
                }
                
                // create a UIImageView for the piece
                let pieceImgView = UIImageView(image: UIImage(cgImage: fromImgRef))
                pieceImgView.frame = tiledRect
                pieceImgView.clipsToBounds = true
                pieceImgView.alpha = 1.0
                tempView.addSubview(pieceImgView)
            }
        }
        
        UIView.animate(withDuration: duration) {
            for (_, view) in tempView.subviews.enumerated() {
                let offsetX = self.randomBetween(small: -100.0, big: 100.0)
                let offsetY = self.randomBetween(small: -100.0, big: 100.0)
                view.frame = CGRectOffset(view.frame, CGFloat(offsetX), CGFloat(offsetY))
                view.alpha = 0.0
                
                let offsetR = self.randomBetween(small: -10.0, big: 10.0)
                let rotation = CGAffineTransformMakeRotation(CGFloat(offsetR))
                view.transform = CGAffineTransformScale(rotation, 0.01, 0.01)
            }
        } completion: { finished in
            if finished {
                tempView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
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
