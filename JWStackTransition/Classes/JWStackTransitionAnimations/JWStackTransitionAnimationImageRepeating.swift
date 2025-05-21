//
//  JWStackTransitionAnimationImageRepeating.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationImageRepeating: JWStackTransitionAnimationDelegate {
    
    private var imageStepPercent : CGFloat = 0.05
    private var imageStepTime : TimeInterval = TimeInterval(0.2)
    private var imageViews : [UIImageView] = []
    
    public init(stepPercent: CGFloat = 0.05, stepTime: TimeInterval = 0.2) {
        self.imageStepPercent = stepPercent
        self.imageStepTime = stepTime
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        if let image = fromVC.view.viewShot() {
            addImageView(transitionContext: transitionContext, fromViewImage: image, imageViewRect: containerView.bounds)
        }
        
    }
    
    private func removeImageView(transitionContext: UIViewControllerContextTransitioning) {
        let imageView = imageViews.first
        imageView?.removeFromSuperview()
        self.imageViews = Array(imageViews.dropFirst())
        
        if imageViews.count ==  0 {
            transitionContext.completeTransition(true)
            return
        }
        
        JWStackTransition.delay(second: self.imageStepTime) {
            self.removeImageView(transitionContext: transitionContext)
        }
    }
    
    private func addImageView(transitionContext: UIViewControllerContextTransitioning, fromViewImage: UIImage, imageViewRect: CGRect) {
        let imageView = UIImageView.init(frame: imageViewRect)
        imageView.clipsToBounds = true
        imageView.image = fromViewImage
        transitionContext.containerView.addSubview(imageView)
        imageViews.append(imageView)
        
        let widthStep = transitionContext.containerView.bounds.size.width * imageStepPercent
        let heightStep = transitionContext.containerView.bounds.size.height * imageStepPercent
        
        if (imageViewRect.size.width - (widthStep * 2) <= 0 || imageViewRect.size.height - (heightStep * 2) <= 0) {
            JWStackTransition.delay(second: self.imageStepTime) {
                self.removeImageView(transitionContext: transitionContext)
            }
            return
        }
        
        let nextImageViewRect = CGRect.init(x: imageViewRect.origin.x + widthStep, y: imageViewRect.origin.y + heightStep, width: imageViewRect.size.width - (widthStep * 2), height: imageViewRect.size.height - (heightStep * 2))
        
        JWStackTransition.delay(second: self.imageStepTime) {
            self.addImageView(transitionContext: transitionContext, fromViewImage: fromViewImage, imageViewRect: nextImageViewRect)
        }
        
        
    }
}

#endif
