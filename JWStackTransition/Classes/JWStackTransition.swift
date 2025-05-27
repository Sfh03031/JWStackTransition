//
//  JWStackTransition.swift
//  JWStackTransition_Example
//
//  Created by sfh on 2025/5/20.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import UIKit

/**
 Enum of animation types used for stack transition.

 - Blank:                       Blank animation.
 - ClockWise:                   ClockWise animation.
 - AntiClockWise:               AntiClockWise animation.
 - Circle:                      Circle animation.
 - Rectangler:                  Rectangler animation.
 - MultiCircle:                 MultiCircle animation.
 - Flip:                        Flip animation.
 - TiledFlip:                   TiledFlip animation.
 - ImageRepeating:              ImageRepeating animation.
 - MultiFlip:                   MultiFlip animation.
 - AngleLine:                   AngleLine animation.
 - ShrinkingGrowingDiamonds:    ShrinkingGrowingDiamonds animation.
 - SwingIn:                     SwingIn animation.
 
 */
public enum JWStackTransitionType {
    
    /**
     Blank.

     - returns: Instance of JWStackTransitionAnimationBlank.
     */
    case blank
    /**
     ClockWise, default animation duration is 0.7, angle range is [0.0, 2.0] and default animation start angle is 0.0.
     
     - returns: Instance of JWStackTransitionAnimationClockWise.
     */
    case clockWise(_ startAngle: Double = 0.0)
    /**
     AntiClockWise, default animation duration is 0.7, angle range is [0.0, 2.0] and default animation start angle is 0.0.
     
     - returns: Instance of JWStackTransitionAnimationAntiClockWise.
     */
    case antiClockWise(_ startAngle: Double = 0.0)
    /**
     Circle.
     
     - returns: Instance of JWStackTransitionAnimationCircle.
     */
    case circle
    /**
     SectorLeft.
     
     - returns: Instance of JWStackTransitionAnimationSector, `left` case of UIRectEdge.
     */
    case sectorLeft
    /**
     SectorTop.
     
     - returns: Instance of JWStackTransitionAnimationSector, `top` case of UIRectEdge.
     */
    case sectorTop
    /**
     SectorRight.
     
     - returns: Instance of JWStackTransitionAnimationSector, `right` case of UIRectEdge.
     */
    case sectorRight
    /**
     SectorBottom.
     
     - returns: Instance of JWStackTransitionAnimationSector, `bottom` case of UIRectEdge.
     */
    case sectorBottom
    /**
     sector.
     
     - returns: Instance of JWStackTransitionAnimationSector.
     */
    case sector(_ edge: JWStackTransitionAnimationRectEdge = .left)
    /**
     Rectangler.
     
     - returns: Instance of JWStackTransitionAnimationRectangler.
     */
    case rectangler
    /**
     MultiCircle.
     
     - returns: Instance of JWStackTransitionAnimationMultiCircle.
     */
    case multiCircle
    /**
     Official, default official type is crossDissolve.
     
     - returns: Instance of JWStackTransitionAnimationOfficial.
     */
    case official(_ type: JWStackTransitionAnimationOfficialType = .crossDissolve)
    /**
     TiledFlip, default animation duration is 1.0.
     
     - returns: Instance of JWStackTransitionAnimationTiledFlip.
     */
    case tiledFlip(duration: TimeInterval = 1.0)
    /**
     ImageRepeating, default step percent is 0.05 and default step time is 0.2.
     
     - returns: Instance of JWStackTransitionAnimationImageRepeating.
     */
    case imageRepeating(percent: CGFloat = 0.05, time: TimeInterval = 0.2)
    /**
     MultiFlip, default step distance is 0.333 and default step time is 0.333.
     
     - returns: Instance of JWStackTransitionAnimationMultiFlip.
     */
    case multiFlip(distance: CGFloat = 0.333, time: TimeInterval = 0.333)
    /**
     Slant, default rect corner is topLeft, `allCorners` == `topLeft`.
     
     - returns: Instance of JWStackTransitionAnimationSlant.
     */
    case slant(_ corner: JWStackTransitionAnimationRectCorner = .topLeft)
    /**
     Split, default split type is horizontal.
     
     - returns: Instance of JWStackTransitionAnimationSplit.
     */
    case split(_ type: JWStackTransitionAnimationSplitType = .horizontal)
    /**
     StraightLine, default rect edge is left.
     
     - returns: Instance of JWStackTransitionAnimationStraightLine.
     */
    case translate(_ edge: JWStackTransitionAnimationRectEdge = .left)
    /**
     ShrinkingGrowingDiamonds, default animation duration is 1.0.
     
     - returns: Instance of JWStackTransitionAnimationShrinkingGrowingDiamonds.
     */
    case shrinkingGrowingDiamonds(duration: TimeInterval = 1.0)
    /**
     SwingIn, default animation duration is 1.0 and default initial direction is left.
     
     - returns: Instance of JWStackTransitionAnimationSwingIn.
     */
    case swing(_ edge: JWStackTransitionAnimationRectEdge = .left)
    
    func animation() -> JWStackTransitionAnimationDelegate {
        switch self {
        case .blank:
            return JWStackTransitionAnimationBlank()
        case .clockWise(let angle):
            return JWStackTransitionAnimationClockWise(angle)
        case .antiClockWise(let angle):
            return JWStackTransitionAnimationAntiClockWise(angle)
        case .circle:
            return JWStackTransitionAnimationCircle()
        case .split(let type):
            return JWStackTransitionAnimationSplit(type)
        case .sector(let edge):
            return JWStackTransitionAnimationSector(edge)
        case .sectorLeft:
            return JWStackTransitionAnimationSector(.left)
        case .sectorTop:
            return JWStackTransitionAnimationSector(.top)
        case .sectorRight:
            return JWStackTransitionAnimationSector(.right)
        case .sectorBottom:
            return JWStackTransitionAnimationSector(.bottom)
        case .rectangler:
            return JWStackTransitionAnimationRectangler()
        case .multiCircle:
            return JWStackTransitionAnimationMultiCircle()
        case .official(let type):
            return JWStackTransitionAnimationOfficial(type)
        case .tiledFlip:
            return JWStackTransitionAnimationTiledFlip()
        case .imageRepeating(let percent, let time):
            return JWStackTransitionAnimationImageRepeating(stepPercent: percent, stepTime: time)
        case .multiFlip(let distance, let time):
            return JWStackTransitionAnimationMultiFlip(distance: distance, time: time)
        case .slant(let type):
            return JWStackTransitionAnimationSlant(type)
        case .translate(let edge):
            return JWStackTransitionAnimationTranslate(edge)
        case .shrinkingGrowingDiamonds:
            return JWStackTransitionAnimationShrinkingGrowingDiamonds()
        case .swing(let edge):
            return JWStackTransitionAnimationSwing(edge)
        }
    }
    
}

public class JWStackTransition: NSObject {
    /// Default type. Default value is .flip.
    public static var DEFAULT_TYPE: JWStackTransitionType = .official(.crossDissolve)
    /// Default time duration of animation. Default value is 0.33 seconds.
    public static var DEFAULT_DURATION: TimeInterval = 0.33
    
    /// Animation type.
    public var type: JWStackTransitionType = JWStackTransition.DEFAULT_TYPE
    /// Animation duration.
    @IBInspectable public var duration: TimeInterval = JWStackTransition.DEFAULT_DURATION
    
    public init(type: JWStackTransitionType? = nil, duration: TimeInterval? = nil) {
        self.type = type ?? JWStackTransition.DEFAULT_TYPE
        self.duration = duration ?? JWStackTransition.DEFAULT_DURATION
        
        switch self.type {
        case .tiledFlip(let duration):
            self.duration = duration
            break
        case .imageRepeating(let percent, let time):
            let imgNum = Int(0.5 / percent)
            self.duration = time * TimeInterval(imgNum * 2)
            break
        case .multiFlip(let distance, let time):
            self.duration = TimeInterval(1.0 / distance) * time
            break
        case .shrinkingGrowingDiamonds(let duration):
            self.duration = duration
            break
        default:
            break
        }
    }
}

extension JWStackTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let animation:JWStackTransitionAnimationDelegate = type.animation()
        animation.setUpAnimation(duration: duration, transitionContext: transitionContext)
    }
    
}


extension JWStackTransition {
    
    static func delay(second: Double, work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second, execute: work)
    }
    
}

#endif
