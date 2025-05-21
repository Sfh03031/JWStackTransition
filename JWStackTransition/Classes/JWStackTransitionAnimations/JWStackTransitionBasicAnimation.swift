//
//  JWStackTransitionBasicAnimation.swift
//  Pods
//
//  Created by sfh on 2025/5/20.
//

#if canImport(QuartzCore)

import QuartzCore

class JWStackTransitionBasicAnimation: CABasicAnimation {
    
    public var animationFinished: (() -> (Void))?
    
    override init() {
        super.init()
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JWStackTransitionBasicAnimation: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.animationFinished?()
        }
    }
    
}

#endif
