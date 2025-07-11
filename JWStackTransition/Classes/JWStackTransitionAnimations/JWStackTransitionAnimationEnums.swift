//
//  JWStackTransitionAnimationEnums.swift
//  Pods
//
//  Created by sfh on 2025/5/27.
//

#if canImport(UIKit)

public enum JWStackTransitionAnimationRectCorner {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

public enum JWStackTransitionAnimationRectEdge {
    case left
    case top
    case right
    case bottom
}

public enum JWStackTransitionAnimationOfficialType {
    case flipFromRight
    case flipFromLeft
    case flipFromTop
    case flipFromBottom
    case curlUp
    case curlDown
    case crossDissolve
}

public enum JWStackTransitionAnimationSplitType {
    case vertical
    case horizontal
    case leftDiagonal
    case rightDiagonal
    case crossDiagonal
    case diamondVertical
    case diamondHorizontal
    case cross
}

public enum JWStackTransitionAnimationFenceType {
    case verticalLeft
    case verticalRight
    case horizontalTop
    case horizontalBottom
    case verticalCross
    case horizontalCross
}

public enum JWStackTransitionAnimationBarrierFadeDirectionType {
    case toTop
    case toBottom
    case toLeft
    case toRight
    case toVerticalCenter
    case toHorizontalCenter
}

public enum JWStackTransitionAnimationRollAxis {
    case x
    case y
    case z
}

public enum JWStackTransitionAnimationRectanglerWave {
    case waveIn
    case waveOut
}

public enum JWStackTransitionAnimationFoldType {
    case fromLeftToRight
    case fromRightToLeft
}

public enum JWStackTransitionAnimationDoorType {
    case verticalOpen
    case verticalClose
    case horizontalOpen
    case horizontalClose
    case horizontal
    case vertical
}

public enum JWStackTransitionAnimationSerrateType {
    case vertical
    case horizontal
}

public enum JWStackTransitionAnimationCubeType {
    case fromLeftToRight
    case fromRightToLeft
    case fromTopToBottom
    case fromBottomToTop
}

public enum JWStackTransitionAnimationPanType {
    case panLeft
    case panRight
    case panTop
    case panBottom
    case panLeftWithShake
    case panRightWithShake
    case panTopWithShake
    case panBottomWithShake
}

public enum JWStackTransitionAnimationNatGeoType {
    case geoLeft
    case geoRight
}

public enum JWStackTransitionAnimationRotateType {
    case clockWise
    case antiClockWise
}

public enum JWStackTransitionAnimationShiftLineType {
    case toTop
    case toRight
    case toBottom
    case toLeft
    case toTopRight
    case toBottomRight
    case toBottomLeft
    case toTopLeft
}

public enum JWStackTransitionAnimationPuzzleType {
    case random
    case fromTop
    case fromRight
    case fromBottom
    case fromLeft
    case fromTopRight
    case fromBottomRight
    case fromBottomLeft
    case fromTopLeft
    case fromHorBoth
    case fromVerBoth
    case vertical
    case horizontal
    case quadrant
}

#endif
