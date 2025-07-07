//
//  JWStackTransitionAnimationParticle.swift
//  Pods
//
//  Created by sfh on 2025/7/4.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationParticle: JWStackTransitionAnimationDelegate {
    
    private var ejectedFrom: CGPoint = .zero // particle ejected from point
    private var particleSize: CGSize = CGSize(width: 20, height: 20) // particle size
    
    init(_ particleEjectedFrom: CGPoint, particleSize: CGSize) {
        self.ejectedFrom = particleEjectedFrom
        self.particleSize = particleSize
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to),
              let toShot = toView.viewShot() else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let tempView = UIView(frame: containerView.bounds)
        containerView.addSubview(tempView)
    
        let pieceW = self.particleSize.width
        let pieceH = self.particleSize.height
        
        let column = Int(ceil(toView.frame.width / pieceW))
        let row = Int(ceil(toView.frame.height / pieceH))
        for i in 0..<column {
            for j in 0..<row {
                let x = pieceW * CGFloat(i)
                let y = pieceH * CGFloat(j)
                
                let tiledRect = CGRect(x: x, y: y, width: pieceW, height: pieceH)
                
                guard let toCGImg = toShot.cgImage,
                      let toImgRef = toCGImg.cropping(to: CGRect(x: toShot.scale * tiledRect.origin.x, y: toShot.scale * tiledRect.origin.y, width: toShot.scale * tiledRect.width, height: toShot.scale * tiledRect.height)) else {
                    print("cropping image failed")
                    return
                }
                
                // create a UIImageView for the piece
                let pieceImgView = UIImageView(image: UIImage(cgImage: toImgRef))
                pieceImgView.frame = tiledRect
                pieceImgView.clipsToBounds = true
                pieceImgView.alpha = 0.0
                tempView.addSubview(pieceImgView)
            }
        }
        
        // record original frames
        var originalFrames: [CGRect] = []
        for view in tempView.subviews {
            originalFrames.append(view.frame)
        }
        
        // shuffle the views
        let views = tempView.subviews
        let shuffledViews = views.shuffled()
        for (index, _) in shuffledViews.enumerated() {
            views[index].center = self.ejectedFrom
        }
        
        // animate the pieces
        for (index, view) in tempView.subviews.enumerated() {
            let random = Float(arc4random()) / Float(UInt32.max)
            let relative = Double(Float(duration * 0.4) * random)

            UIView.animateKeyframes(withDuration: duration - relative, delay: relative, options: .calculationModeLinear) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                    view.alpha = 1
                })
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                    view.frame = originalFrames[index]
                })
            } completion: { finished in
                if finished {
                    tempView.removeFromSuperview()
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }
    }
}

#endif
