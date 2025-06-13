//
//  JWStackTransitionAnimationOfficial.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationOfficial: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationOfficialType = .flipFromRight
    
    init(_ type: JWStackTransitionAnimationOfficialType) {
        self.type = type
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        
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
        
        UIView.transition(with: containerView, duration: duration, options: options, animations: {
            containerView.addSubview(toView)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}

#endif
