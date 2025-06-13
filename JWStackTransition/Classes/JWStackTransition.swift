//
//  JWStackTransition.swift
//  JWStackTransition_Example
//
//  Created by sfh on 2025/5/20.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransition: NSObject {
    /// Default type. Default value is .flip.
    public static var DEFAULT_TYPE: JWStackTransitionType = .official
    /// Default time duration of animation. Default value is 0.7 seconds.
    public static var DEFAULT_DURATION: TimeInterval = 0.7
    
    /// Animation type.
    public var type: JWStackTransitionType = JWStackTransition.DEFAULT_TYPE
    /// Animation duration.
    @IBInspectable public var duration: TimeInterval = JWStackTransition.DEFAULT_DURATION
    
    public init(type: JWStackTransitionType? = nil, duration: TimeInterval? = nil) {
        self.type = type ?? JWStackTransition.DEFAULT_TYPE
        self.duration = duration ?? JWStackTransition.DEFAULT_DURATION
    }
}

extension JWStackTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let animation: JWStackTransitionAnimationDelegate = type.animation()
        animation.setUpAnimation(duration: duration, transitionContext: transitionContext)
    }
    
}

extension JWStackTransition {
    
    static func delay(second: Double, work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second, execute: work)
    }
    
}

#endif
