//
//  JWStackTransitionAnimationMultinest.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationMultinest: JWStackTransitionAnimationDelegate {
    
    private var percent: CGFloat = 0.05 // animation step percent
    private var duration: TimeInterval = TimeInterval(0.1) // animation step duration
    
    private var imageViews: [UIImageView] = []

    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        if let image = fromVC.view.viewShot() {
            add(transitionContext, img: image, imgRect: containerView.bounds)
        }
        
    }
    
}

extension JWStackTransitionAnimationMultinest {
    
    /// add temp view
    /// - Parameters:
    ///   - img: shot image
    ///   - imgRect: show image rect
    func add(_ transitionContext: UIViewControllerContextTransitioning, img: UIImage, imgRect: CGRect) {
        let imgView = UIImageView(image: img)
        imgView.frame = imgRect
        imgView.clipsToBounds = true
        transitionContext.containerView.addSubview(imgView)
        
        imageViews.append(imgView)
        
        let stepW = transitionContext.containerView.bounds.width * self.percent
        let stepH = transitionContext.containerView.bounds.height * self.percent
        
        if (imgRect.width - (stepW * 2) <= 0 || imgRect.height - (stepH * 2) <= 0) {
            JWStackTransition.delay(second: self.duration) {
                self.remove(transitionContext)
            }
            return
        }
        
        let next = CGRect(x: imgRect.origin.x + stepW,
                          y: imgRect.origin.y + stepH,
                          width: imgRect.width - (stepW * 2),
                          height: imgRect.height - (stepH * 2)
        )
        
        JWStackTransition.delay(second: self.duration) {
            self.add(transitionContext, img: img, imgRect: next)
        }
        
    }
    
    /// remove temp view
    func remove(_ transitionContext: UIViewControllerContextTransitioning) {
        let imageView = imageViews.first
        imageView?.removeFromSuperview()
        self.imageViews = Array(imageViews.dropFirst())
        
        if imageViews.count ==  0 {
            transitionContext.completeTransition(true)
            return
        }
        
        JWStackTransition.delay(second: self.duration) {
            self.remove(transitionContext)
        }
    }
    
}

#endif
