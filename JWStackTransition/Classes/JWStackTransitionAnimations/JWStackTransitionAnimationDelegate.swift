//
//  JWStackTransitionAnimationDelegate.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(UIKit)

import UIKit

protocol JWStackTransitionAnimationDelegate {
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning)
    
}

#endif
