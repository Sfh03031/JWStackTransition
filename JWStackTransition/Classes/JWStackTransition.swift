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
     AntiClockWise, default animation start angle is `0.0`, angle range is `[0.0, 2.0]`.
     
     - returns: Instance of JWStackTransitionAnimationAntiClockWise.
     */
    case antiClockWise(_ startAngle: Double)
    /**
     Barrier, default animation type is `toTop`, default barrier width is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationBarrier.
     */
    case barrier(_ type: JWStackTransitionAnimationBarrierFadeDirectionType, width: CGFloat)
    /**
     Blank.

     - returns: Instance of JWStackTransitionAnimationBlank.
     */
    case blank
    /**
     Circle.
     
     - returns: Instance of JWStackTransitionAnimationCircle.
     */
    case circle
    /**
     ClockWise, default animation start angle is `0.0`, angle range is `[0.0, 2.0]`.
     
     - returns: Instance of JWStackTransitionAnimationClockWise.
     */
    case clockWise(_ startAngle: Double)
    /**
     Fence, default animation type is `verticalLeft`, default fence width is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationFence.
     */
    case fence(_ type: JWStackTransitionAnimationFenceType, width: CGFloat)
    /**
     MultiCircle, default single circle diameter is `20.0`, diameter range is `(0, 100]`.
     
     - returns: Instance of JWStackTransitionAnimationMultiCircle.
     */
    case multiCircle(_ diameter: CGFloat)
    /**
     Multinest.
     
     - returns: Instance of JWStackTransitionAnimationMultinest.
     */
    case multinest
    /**
     Official, default animation type is `crossDissolve`.
     
     - returns: Instance of JWStackTransitionAnimationOfficial.
     */
    case official(_ type: JWStackTransitionAnimationOfficialType)
    /**
     Rectangler, default animation type is `waveIn`.
     
     - returns: Instance of JWStackTransitionAnimationRectangler.
     */
    case rectangler(_ wave: JWStackTransitionAnimationRectanglerWave)
    /**
     Roll, default animation roll axis is `y`.
     
     - returns: Instance of JWStackTransitionAnimationRoll.
     */
    case roll(_ axis: JWStackTransitionAnimationRollAxis)
    /**
     Rotate.
     
     - returns: Instance of JWStackTransitionAnimationRotate.
     */
    case rotate
    /**
     Sector, default animation rect edge is `left`.
     
     - returns: Instance of JWStackTransitionAnimationSector.
     */
    case sector(_ edge: JWStackTransitionAnimationRectEdge)
    /**
     Slant, default animation rect corner is `topLeft`.
     
     - returns: Instance of JWStackTransitionAnimationSlant.
     */
    case slant(_ corner: JWStackTransitionAnimationRectCorner)
    /**
     Split, default split type is `horizontal`.
     
     - returns: Instance of JWStackTransitionAnimationSplit.
     */
    case split(_ type: JWStackTransitionAnimationSplitType)
    /**
     Swing, default animation rect edge is `left`.
     
     - returns: Instance of JWStackTransitionAnimationSwing.
     */
    case swing(_ edge: JWStackTransitionAnimationRectEdge)
    /**
     TiledFlip, animation type is flipFromRight, tiled row is 10 and column is 5.
     
     - returns: Instance of JWStackTransitionAnimationTiledFlip.
     */
    case tiledFlip
    /**
     Translate, default animation rect edge is `left`.
     
     - returns: Instance of JWStackTransitionAnimationTranslate.
     */
    case translate(_ edge: JWStackTransitionAnimationRectEdge)
    
    
    
    
    
    
    
    
    
    /**
     SectorLeft.
     
     - returns: Instance of JWStackTransitionAnimationSector, `left` case of JWStackTransitionAnimationRectEdge.
     */
    case sectorLeft
    /**
     SectorTop.
     
     - returns: Instance of JWStackTransitionAnimationSector, `top` case of JWStackTransitionAnimationRectEdge.
     */
    case sectorTop
    /**
     SectorRight.
     
     - returns: Instance of JWStackTransitionAnimationSector, `right` case of JWStackTransitionAnimationRectEdge.
     */
    case sectorRight
    /**
     SectorBottom.
     
     - returns: Instance of JWStackTransitionAnimationSector, `bottom` case of JWStackTransitionAnimationRectEdge.
     */
    case sectorBottom
    
    
    
    
    /**
     TiledFlipCustomized, default animation type is flipFromRight, default tiled row is 10 and range is (0, 20], default tiled column is 5 and range is (0, 10].
     
     - returns: Instance of JWStackTransitionAnimationTiledFlip.
     */
    case tiledFlipCustomized(_ type: JWStackTransitionAnimationOfficialType, tiledRow: Int, tiledColumn: Int)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
        case .rectangler(let wave):
            return JWStackTransitionAnimationRectangler(wave)
        case .multiCircle(let diameter):
            return JWStackTransitionAnimationMultiCircle(diameter)
        case .official(let type):
            return JWStackTransitionAnimationOfficial(type)
        case .tiledFlip:
            return JWStackTransitionAnimationTiledFlip(.flipFromRight, tiledRow: 0, tiledColumn: 0)
        case .tiledFlipCustomized(let type, let row, let column):
            return JWStackTransitionAnimationTiledFlip(type, tiledRow: row, tiledColumn: column)
        case .multinest:
            return JWStackTransitionAnimationMultinest()
        case .roll(let axis):
            return JWStackTransitionAnimationRoll(axis)
        case .slant(let type):
            return JWStackTransitionAnimationSlant(type)
        case .translate(let edge):
            return JWStackTransitionAnimationTranslate(edge)
        case .swing(let edge):
            return JWStackTransitionAnimationSwing(edge)
        case .rotate:
            return JWStackTransitionAnimationRotate()
        case .fence(let type, let width):
            return JWStackTransitionAnimationFence(type, width: width)
        case .barrier(let type, let width):
            return JWStackTransitionAnimationBarrier(type, width: width)
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
