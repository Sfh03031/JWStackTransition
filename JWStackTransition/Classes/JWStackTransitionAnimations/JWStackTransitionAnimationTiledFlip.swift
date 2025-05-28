//
//  JWStackTransitionAnimationTiledFlip.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationTiledFlip: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationOfficialType = .flipFromRight // animation type
    private var row: Int = 10 // tiled animation row number, range is (0, 20]
    private var column: Int = 5 // tiled animation column number, range is (0, 10]
    
    init(_ type: JWStackTransitionAnimationOfficialType, tiledRow: Int, tiledColumn: Int) {
        self.type = type
        if tiledRow > 0 && tiledRow <= 20 {
            self.row = tiledRow
        }
        if tiledColumn > 0 && tiledColumn <= 10 {
            self.column = tiledColumn
        }
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let fromShotImg = fromVC.view.viewShot(),
              let toShotImg = toVC.view.viewShot() else { return }
        
        let containerView = transitionContext.containerView
        fromVC.view.removeFromSuperview()
        
        let tempView = UIView()
        tempView.backgroundColor = .clear
        tempView.frame = fromVC.view.frame
        containerView.addSubview(tempView)

        let blockW:CGFloat = fromVC.view.bounds.width / CGFloat(self.column)
        let blockH:CGFloat = fromVC.view.bounds.height / CGFloat(self.row)
        
        let columnNum = 1 + Int(toVC.view.bounds.width / blockW)
        let rowNum = 1 + Int(toVC.view.bounds.height / blockH)
        for i in 0...columnNum { // 0..<n, [0, n); 0...n, [0, n]
            for j in 0...rowNum {
                let blockFrame = CGRect(x: CGFloat(i) * blockW, y: CGFloat(j) * blockH, width: blockW, height: blockH)
                
                let random = Float(arc4random()) / Float(UInt32.max)
                let delay = TimeInterval(Float(duration * 0.5) * random)
                
                self.makeTiledFlipAnimation(fromShot: fromShotImg, toShot: toShotImg, delay: delay, tiledSize: blockFrame, duration: duration / 2, superView: tempView)
            }
        }
        
        JWStackTransition.delay(second: duration) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            containerView.addSubview(toVC.view)
            tempView.removeFromSuperview()
        }
    }
    
}

extension JWStackTransitionAnimationTiledFlip {
    
    /// add single tiled flip animation
    /// - Parameters:
    ///   - fromShot: fromVC view shot image
    ///   - toShot: toVC view shot image
    ///   - delay: animation delay time duration
    ///   - tiledSize: single tiled size
    ///   - duration: animation duration
    ///   - super: super view of tiled
    func makeTiledFlipAnimation(fromShot: UIImage, toShot: UIImage, delay: TimeInterval, tiledSize: CGRect, duration: TimeInterval, superView: UIView) {
        guard let fromCGImg = fromShot.cgImage,
              let toCGImg = toShot.cgImage,
              let fromImgRef = fromCGImg.cropping(to: CGRect(x: fromShot.scale * tiledSize.origin.x, y: fromShot.scale * tiledSize.origin.y, width: fromShot.scale * tiledSize.size.width, height: fromShot.scale * tiledSize.size.height)),
              let toImgRef = toCGImg.cropping(to: CGRect(x: toShot.scale * tiledSize.origin.x, y: toShot.scale * tiledSize.origin.y, width: toShot.scale * tiledSize.size.width, height: toShot.scale * tiledSize.size.height)) else { return }
        
        let fromImgView = UIImageView(image: UIImage(cgImage: fromImgRef))
        fromImgView.frame = tiledSize
        fromImgView.clipsToBounds = true
        
        let toImgView = UIImageView(image: UIImage(cgImage: toImgRef))
        toImgView.frame = tiledSize
        toImgView.clipsToBounds = true
        
        let containerView = UIView()
        containerView.frame = fromImgView.frame
        containerView.backgroundColor = .clear
        
        fromImgView.frame.origin = .zero
        toImgView.frame.origin = .zero
        
        containerView.addSubview(fromImgView)
        superView.addSubview(containerView)
        
        let options = self.getAnimationOptions()
        JWStackTransition.delay(second: delay) {
            UIView.transition(with: containerView, duration: duration, options: options, animations: {
                containerView.addSubview(toImgView)
                fromImgView.removeFromSuperview()
            })
        }
    }
    
    /// get animation options
    /// - Returns: UIView.AnimationOptions
    func getAnimationOptions() -> UIView.AnimationOptions {
        var options: UIView.AnimationOptions = []
        switch self.type {
        case .flipFromTop:
            options = [.transitionFlipFromTop, .curveEaseInOut]
            break
        case .flipFromLeft:
            options = [.transitionFlipFromLeft, .curveEaseInOut]
            break
        case .flipFromRight:
            options = [.transitionFlipFromRight, .curveEaseInOut]
            break
        case .flipFromBottom:
            options = [.transitionFlipFromBottom, .curveEaseInOut]
            break
        case .curlUp:
            options = [.transitionCurlUp, .curveEaseInOut]
            break
        case .curlDown:
            options = [.transitionCurlDown, .curveEaseInOut]
            break
        case .crossDissolve:
            options = [.transitionCrossDissolve, .curveEaseInOut]
            break
        }
        
        return options
    }
}

#endif
