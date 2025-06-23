//
//  JWStackTransitionType.swift
//  Pods
//
//  Created by sfh on 2025/6/12.
//

#if canImport(UIKit)

import UIKit

/**
 Enum of animation types used for stack transition.

 - AntiClockWise:               AntiClockWise animation.
 - Barrier:                     Barrier animation.
 - Blank:                       Blank animation.
 - Circle:                      Circle animation.
 - ClockWise:                   ClockWise animation.
 - Cube:                        Cube animation.
 - Door:                        Door animation.
 - Explode:                     Explode animation.
 - Fence:                       Fence animation.
 - Flip:                        Flip animation.
 - Fold:                        Fold animation.
 - MultiCircle:                 MultiCircle animation.
 - Multinest:                   Multinest animation.
 - NatGeo:                      NatGeo animation.
 - Official:                    Official animation.
 - Pan:                         Pan animation.
 - Rectangler:                  Rectangler animation.
 - Roll:                        Roll animation.
 - Rotate                       Rotate animation.
 - Sector                       Sector animation.
 - Slant                        Slant animation.
 - Split                        Split animation.
 - Swing                        Swing animation.
 - TiledFlip                    TiledFlip animation.
 - Translate                    Translate animation.
 
 - AntiClockWiseCustomized:     AntiClockWiseCustomized animation.
 - BarrierCustomized:           BarrierCustomized animation.
 - ClockWiseCustomized:         ClockWiseCustomized animation.
 - CubeCustomized:              CubeCustomized animation.
 - DoorCustomized:              DoorCustomized animation.
 - ExplodeCustomized:           ExplodeCustomized animation.
 - FenceCustomized:             FenceCustomized animation.
 - FlipCustomized:              FlipCustomized animation.
 - FoldCustomized:              FoldCustomized animation.
 - MultiCircleCustomized:       MultiCircleCustomized animation.
 - NatGeoCustomized:            NatGeoCustomized animation.
 - OfficialCustomized:          OfficialCustomized animation.
 - PanCustomized:               PanCustomized animation.
 - RectanglerCustomized:        RectanglerCustomized animation.
 - RollCustomized:              RollCustomized animation.
 - SectorCustomized             SectorCustomized animation.
 - SlantCustomized              SlantCustomized animation.
 - SplitCustomized              SplitCustomized animation.
 - SwingCustomized              SwingCustomized animation.
 - TiledFlipCustomized          TiledFlipCustomized animation.
 - TranslateCustomized          TranslateCustomized animation.
 
 */
public enum JWStackTransitionType {
    
    /// All default animation types
    public static var allCases: [JWStackTransitionType] = [.antiClockWise, .barrier, .blank, .circle, .clockWise, .cube, .door, .explode, .fence, .flip, .fold, .multiCircle, .multinest, .natGeo, .official, .pan, .rectangler, .roll, .rotate, .sector, .slant, .split, .swing, .tiledFlip, .translate]
    
    /**
     AntiClockWise, start angle is `1.5`.
     
     - returns: Instance of JWStackTransitionAnimationAntiClockWise.
     */
    case antiClockWise
    /**
     AntiClockWiseCustomized, default animation start angle is `1.5`, angle range is `[0.0, 2.0]`.
     
     - returns: Instance of JWStackTransitionAnimationAntiClockWise.
     */
    case antiClockWiseCustomized(_ startAngle: Double)
    /**
     Barrier, case `toTop` of JWStackTransitionAnimationBarrierFadeDirectionType and barrier width is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationBarrier.
     */
    case barrier
    /**
     BarrierCustomized, default animation type is `toTop`, default barrier width is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationBarrier.
     */
    case barrierCustomized(_ type: JWStackTransitionAnimationBarrierFadeDirectionType, width: CGFloat)
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
     ClockWise, start angle is `0.5`.
     
     - returns: Instance of JWStackTransitionAnimationClockWise.
     */
    case clockWise
    /**
     ClockWiseCustomized, default animation start angle is `0.5`, angle range is `[0.0, 2.0]`.
     
     - returns: Instance of JWStackTransitionAnimationClockWise.
     */
    case clockWiseCustomized(_ startAngle: Double)
    /**
     Cube, case `fromLeftToRight` of JWStackTransitionAnimationCubeType.
     
     - returns: Instance of JWStackTransitionAnimationCube.
     */
    case cube
    /**
     CubeCustomized, default animation case is `fromLeftToRight` of JWStackTransitionAnimationCubeType.
     
     - returns: Instance of JWStackTransitionAnimationCube.
     */
    case cubeCustomized(_ type: JWStackTransitionAnimationCubeType)
    /**
     Door, case `horizontalOpen` of JWStackTransitionAnimationDoorType and animation scale is `0.8`.
     
     - returns: Instance of JWStackTransitionAnimationDoor.
     */
    case door
    /**
     DoorCustomized, default animation type is `horizontalOpen`, default animation scale is `0.8` and range is `(0.0, 1.0]`.
     
     - returns: Instance of JWStackTransitionAnimationDoor.
     */
    case doorCustomized(_ type: JWStackTransitionAnimationDoorType, scale: CGFloat)
    /**
     Explode, piece width is 30.0.
     
     - returns: Instance of JWStackTransitionAnimationExplode.
     */
    case explode
    /**
     ExplodeCustomized, default explode piece width is 30.0.
     
     - returns: Instance of JWStackTransitionAnimationExplode.
     */
    case explodeCustomized(_ pieceWidth: CGFloat)
    /**
     Fence, case `verticalLeft` of JWStackTransitionAnimationFenceType and fence width is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationFence.
     */
    case fence
    /**
     FenceCustomized, default animation type is `verticalLeft`, default fence width is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationFence.
     */
    case fenceCustomized(_ type: JWStackTransitionAnimationFenceType, width: CGFloat)
    /**
     Flip, case `fromLeftToRight` of JWStackTransitionAnimationFoldDirectionType.
     
     - returns: Instance of JWStackTransitionAnimationFlip.
     */
    case flip
    /**
     FlipCustomized, default animation type is `fromLeftToRight`.
     
     - returns: Instance of JWStackTransitionAnimationFlip.
     */
    case flipCustomized(_ type: JWStackTransitionAnimationFoldType)
    /**
     Fold, case `fromLeftToRight` of JWStackTransitionAnimationFoldDirectionType and fold number is `2`.
     
     - returns: Instance of JWStackTransitionAnimationFold.
     */
    case fold
    /**
     FoldCustomized, default animation type is `fromLeftToRight`, default fold number is `2`.
     
     - returns: Instance of JWStackTransitionAnimationFold.
     */
    case foldCustomized(_ type: JWStackTransitionAnimationFoldType, foldNum: Int)
    /**
     MultiCircle, circle diameter is `20.0`.
     
     - returns: Instance of JWStackTransitionAnimationMultiCircle.
     */
    case multiCircle
    /**
     MultiCircleCustomized, default single circle diameter is `20.0`, diameter range is `(0, 100]`.
     
     - returns: Instance of JWStackTransitionAnimationMultiCircle.
     */
    case multiCircleCustomized(_ diameter: CGFloat)
    /**
     Multinest.
     
     - returns: Instance of JWStackTransitionAnimationMultinest.
     */
    case multinest
    /**
     NatGeo, case `geoLeft` of JWStackTransitionAnimationNatGeoType.
     
     - returns: Instance of JWStackTransitionAnimationNatGeo.
     */
    case natGeo
    /**
     NatGeoCustomized, default animation type is `geoLeft`.
     
     - returns: Instance of JWStackTransitionAnimationNatGeo.
     */
    case natGeoCustomized(_ type: JWStackTransitionAnimationNatGeoType)
    /**
     Official, case `crossDissolve` of JWStackTransitionAnimationOfficialType.
     
     - returns: Instance of JWStackTransitionAnimationOfficial.
     */
    case official
    /**
     OfficialCustomized, default animation type is `crossDissolve`.
     
     - returns: Instance of JWStackTransitionAnimationOfficial.
     */
    case officialCustomized(_ type: JWStackTransitionAnimationOfficialType)
    /**
     Pan, case `panLeft` of JWStackTransitionAnimationPanType.
     
     - returns: Instance of JWStackTransitionAnimationPan.
     */
    case pan
    /**
     PanCustomized, default animation type is `panLeft`.
     
     - returns: Instance of JWStackTransitionAnimationPan.
     */
    case panCustomized(_ type: JWStackTransitionAnimationPanType)
    /**
     Rectangler, case `waveIn` of JWStackTransitionAnimationRectanglerWave.
     
     - returns: Instance of JWStackTransitionAnimationRectangler.
     */
    case rectangler
    /**
     RectanglerCustomized, default animation type is `waveIn`.
     
     - returns: Instance of JWStackTransitionAnimationRectangler.
     */
    case rectanglerCustomized(_ wave: JWStackTransitionAnimationRectanglerWave)
    /**
     Roll, case `y` of JWStackTransitionAnimationRollAxis.
     
     - returns: Instance of JWStackTransitionAnimationRoll.
     */
    case roll
    /**
     RollCustomized, default animation roll axis is `y`.
     
     - returns: Instance of JWStackTransitionAnimationRoll.
     */
    case rollCustomized(_ axis: JWStackTransitionAnimationRollAxis)
    /**
     Rotate.
     
     - returns: Instance of JWStackTransitionAnimationRotate.
     */
    case rotate
    /**
     Sector, case `left` of JWStackTransitionAnimationRectEdge.
     
     - returns: Instance of JWStackTransitionAnimationSector.
     */
    case sector
    /**
     sectorCustomized, default animation rect edge is `left`.
     
     - returns: Instance of JWStackTransitionAnimationSector.
     */
    case sectorCustomized(_ edge: JWStackTransitionAnimationRectEdge)
    /**
     Slant, case `topLeft` of JWStackTransitionAnimationRectCorner.
     
     - returns: Instance of JWStackTransitionAnimationSlant.
     */
    case slant
    /**
     SlantCustomized, default animation rect corner is `topLeft`.
     
     - returns: Instance of JWStackTransitionAnimationSlant.
     */
    case slantCustomized(_ corner: JWStackTransitionAnimationRectCorner)
    /**
     Split, case `horizontal` of JWStackTransitionAnimationSplitType.
     
     - returns: Instance of JWStackTransitionAnimationSplit.
     */
    case split
    /**
     SplitCustomized, default split type is `horizontal`.
     
     - returns: Instance of JWStackTransitionAnimationSplit.
     */
    case splitCustomized(_ type: JWStackTransitionAnimationSplitType)
    /**
     Swing, case `left` of JWStackTransitionAnimationRectEdge.
     
     - returns: Instance of JWStackTransitionAnimationSwing.
     */
    case swing
    /**
     SwingCustomized, default animation rect edge is `left`.
     
     - returns: Instance of JWStackTransitionAnimationSwing.
     */
    case swingCustomized(_ edge: JWStackTransitionAnimationRectEdge)
    /**
     TiledFlip, case `flipFromRight` of JWStackTransitionAnimationOfficialType, tiled row is 10 and column is 5.
     
     - returns: Instance of JWStackTransitionAnimationTiledFlip.
     */
    case tiledFlip
    /**
     TiledFlipCustomized, default animation type is `flipFromRight`, default tiled row is `10` and range is `(0, 20]`, default tiled column is `5` and range is `(0, 10]`.
     
     - returns: Instance of JWStackTransitionAnimationTiledFlip.
     */
    case tiledFlipCustomized(_ type: JWStackTransitionAnimationOfficialType, tiledRow: Int, tiledColumn: Int)
    /**
     Translate, case `left` of JWStackTransitionAnimationRectEdge.
     
     - returns: Instance of JWStackTransitionAnimationTranslate.
     */
    case translate
    /**
     TranslateCustomized, default animation rect edge is `left`.
     
     - returns: Instance of JWStackTransitionAnimationTranslate.
     */
    case translateCustomized(_ edge: JWStackTransitionAnimationRectEdge)
}

extension JWStackTransitionType {
    
    func animation() -> JWStackTransitionAnimationDelegate {
        switch self {
        case .antiClockWise:
            return JWStackTransitionAnimationAntiClockWise(1.5)
        case .antiClockWiseCustomized(let angle):
            return JWStackTransitionAnimationAntiClockWise(angle)
        case .barrier:
            return JWStackTransitionAnimationBarrier(.toTop, width: 20.0)
        case .barrierCustomized(let type, let width):
            return JWStackTransitionAnimationBarrier(type, width: width)
        case .blank:
            return JWStackTransitionAnimationBlank()
        case .circle:
            return JWStackTransitionAnimationCircle()
        case .clockWise:
            return JWStackTransitionAnimationClockWise(0.5)
        case .clockWiseCustomized(let angle):
            return JWStackTransitionAnimationClockWise(angle)
        case .cube:
            return JWStackTransitionAnimationCube(.fromLeftToRight)
        case .cubeCustomized(let type):
            return JWStackTransitionAnimationCube(type)
        case .door:
            return JWStackTransitionAnimationDoor(.horizontalOpen, scale: 0.8)
        case .doorCustomized(let type, let scale):
            return JWStackTransitionAnimationDoor(type, scale: scale)
        case .explode:
            return JWStackTransitionAnimationExplode(30.0)
        case .explodeCustomized(let width):
            return JWStackTransitionAnimationExplode(width)
        case .fence:
            return JWStackTransitionAnimationFence(.verticalLeft, width: 20.0)
        case .fenceCustomized(let type, let width):
            return JWStackTransitionAnimationFence(type, width: width)
        case .flip:
            return JWStackTransitionAnimationFlip(.fromLeftToRight)
        case .flipCustomized(let type):
            return JWStackTransitionAnimationFlip(type)
        case .fold:
            return JWStackTransitionAnimationFold(.fromLeftToRight, foldNum: 2)
        case .foldCustomized(let type, let number):
            return JWStackTransitionAnimationFold(type, foldNum: number)
        case .multiCircle:
            return JWStackTransitionAnimationMultiCircle(20.0)
        case .multiCircleCustomized(let diameter):
            return JWStackTransitionAnimationMultiCircle(diameter)
        case .multinest:
            return JWStackTransitionAnimationMultinest()
        case .natGeo:
            return JWStackTransitionAnimationNatGeo(.geoLeft)
        case .natGeoCustomized(let type):
            return JWStackTransitionAnimationNatGeo(type)
        case .official:
            return JWStackTransitionAnimationOfficial(.crossDissolve)
        case .officialCustomized(let type):
            return JWStackTransitionAnimationOfficial(type)
        case .pan:
            return JWStackTransitionAnimationPan(.panLeft)
        case .panCustomized(let type):
            return JWStackTransitionAnimationPan(type)
        case .rectangler:
            return JWStackTransitionAnimationRectangler(.waveIn)
        case .rectanglerCustomized(let wave):
            return JWStackTransitionAnimationRectangler(wave)
        case .roll:
            return JWStackTransitionAnimationRoll(.y)
        case .rollCustomized(let axis):
            return JWStackTransitionAnimationRoll(axis)
        case .rotate:
            return JWStackTransitionAnimationRotate()
        case .sector:
            return JWStackTransitionAnimationSector(.left)
        case .sectorCustomized(let edge):
            return JWStackTransitionAnimationSector(edge)
        case .slant:
            return JWStackTransitionAnimationSlant(.topLeft)
        case .slantCustomized(let type):
            return JWStackTransitionAnimationSlant(type)
        case .split:
            return JWStackTransitionAnimationSplit(.horizontal)
        case .splitCustomized(let type):
            return JWStackTransitionAnimationSplit(type)
        case .swing:
            return JWStackTransitionAnimationSwing(.left)
        case .swingCustomized(let edge):
            return JWStackTransitionAnimationSwing(edge)
        case .tiledFlip:
            return JWStackTransitionAnimationTiledFlip(.flipFromRight, tiledRow: 0, tiledColumn: 0)
        case .tiledFlipCustomized(let type, let row, let column):
            return JWStackTransitionAnimationTiledFlip(type, tiledRow: row, tiledColumn: column)
        case .translate:
            return JWStackTransitionAnimationTranslate(.left)
        case .translateCustomized(let edge):
            return JWStackTransitionAnimationTranslate(edge)
        }
    }
    
}

#endif
