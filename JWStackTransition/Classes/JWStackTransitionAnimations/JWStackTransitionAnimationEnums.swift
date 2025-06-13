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

#endif
