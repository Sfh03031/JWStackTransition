# JWStackTransition

[![CI Status](https://img.shields.io/travis/Sfh03031/JWStackTransition.svg?style=flat)](https://travis-ci.org/Sfh03031/JWStackTransition)
[![Version](https://img.shields.io/cocoapods/v/JWStackTransition.svg?style=flat)](https://cocoapods.org/pods/JWStackTransition)
[![License](https://img.shields.io/cocoapods/l/JWStackTransition.svg?style=flat)](https://cocoapods.org/pods/JWStackTransition)
[![Platform](https://img.shields.io/cocoapods/p/JWStackTransition.svg?style=flat)](https://cocoapods.org/pods/JWStackTransition)

## Introduction

## All animation types and some examples

The library currently contains the following animations

+ **AntiClockWise**

  + **anticlockwise** - default case which is the same as `anticlockwiseCustomized(1.5)`.
    
  + **anticlockwiseCustomized(startAngle: CGFloat)** - default animation start angle is `1.5`, angle range is `[0.0, 2.0]`.

<table>
    <tr>
        <td><img src="image/animations/AntiClockWise/custom_0.gif"></td>
        <td><img src="image/animations/AntiClockWise/custom_0.5.gif"></td>
        <td><img src="image/animations/AntiClockWise/custom_1.0.gif"></td>
        <td><img src="image/animations/AntiClockWise/default.gif"></td>
        <td><img src="image/animations/AntiClockWise/custom_2.0.gif"></td>
    </tr>
        <tr>
        <th>start angle is 0.0</th>
        <th>start angle is 0.5</th>
        <th>start angle is 1.0</th>
        <th>start angle is 1.5</th>
        <th>start angle is 2.0</th>
    </tr>
</table>

****

+ **Barrier**

  + **barrier** - default case which is the same as `barrierCustomized(.toTop, width: 20.0)`.
  
  + **barrierCustomized(_ type: JWStackTransitionAnimationBarrierFadeDirectionType, width: CGFloat)** - default animation type is `toTop`, default barrier width is `20.0`.

<table>
    <tr>
        <td><img src="image/animations/Barrier/default.gif"></td>
        <td><img src="image/animations/Barrier/custom_toLeft.gif"></td>
        <td><img src="image/animations/Barrier/custom_toRight.gif"></td>
        <td><img src="image/animations/Barrier/custom_toBottom.gif"></td>
    </tr>
    <tr>
        <th>toTop and width is 20</th>
        <th>toLeft and width is 5</th>
        <th>toRight and width is 10</th>
        <th>toBottom and width is 15</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Barrier/custom_toVerticalCenter.gif"></td>
        <td><img src="image/animations/Barrier/custom_toHorizontalCenter.gif"></td>
    </tr>
    <tr>
        <th>toVerticalCenter, 20</th>
        <th>toHorizontalCenter, 25</th>
    </tr>
</table>

****

+ **Circle**

  + **circle**
  
<div align="left" >
  <img width="20%" src="image/animations/Circle/default.gif" />
</div>
  
****

+ **ClockWise**

  + **clockWise** - default case which is the same as `clockWiseCustomized(0.5)`.
    
  + **clockWiseCustomized(_ startAngle: Double)** - default animation start angle is `0.5`, angle range is `[0.0, 2.0]`.

<table>
    <tr>
        <td><img src="image/animations/ClockWise/custom_00.gif"></td>
        <td><img src="image/animations/ClockWise/default.gif"></td>
        <td><img src="image/animations/ClockWise/custom_10.gif"></td>
        <td><img src="image/animations/ClockWise/custom_15.gif"></td>
        <td><img src="image/animations/ClockWise/custom_20.gif"></td>
    </tr>
        <tr>
        <th>start angle is 0.0</th>
        <th>start angle is 0.5</th>
        <th>start angle is 1.0</th>
        <th>start angle is 1.5</th>
        <th>start angle is 2.0</th>
    </tr>
</table>

****

+ **Cube**

  + **cube** - default case which is the same as `cubeCustomized(.fromLeftToRight)`
    
  + **cubeCustomized(_ type: JWStackTransitionAnimationCubeType)** - default animation case is `fromLeftToRight`.

<table>
    <tr>
        <td><img src="image/animations/Cube/fromLeftToRight.gif"></td>
        <td><img src="image/animations/Cube/fromRightToLeft.gif"></td>
        <td><img src="image/animations/Cube/fromTopToBottom.gif"></td>
        <td><img src="image/animations/Cube/fromBottomToTop.gif"></td>
    </tr>
        <tr>
        <th>fromLeftToRight</th>
        <th>fromRightToLeft</th>
        <th>fromTopToBottom</th>
        <th>fromBottomToTop</th>
    </tr>
</table>

****

+ **Door**

  + **door** - default case which is the same as `doorCustomized(.horizontalOpen, scale: 0.8)`
    
  + **doorCustomized(_ type: JWStackTransitionAnimationDoorType, scale: CGFloat)** - default animation case is `horizontalOpen`, default animation scale is `0.8` and range is `(0.0, 1.0]`.

<table>
    <tr>
        <td><img src="image/animations/Door/horOpen.gif"></td>
        <td><img src="image/animations/Door/horClose.gif"></td>
        <td><img src="image/animations/Door/verOpen.gif"></td>
        <td><img src="image/animations/Door/verClose.gif"></td>
    </tr>
        <tr>
        <th>horizontalOpen and scale is 0.8</th>
        <th>horizontalClose and scale is 0.6</th>
        <th>verticalOpen and scale is 0.4</th>
        <th>verticalClose and scale is 0.2</th>
    </tr>
</table>

****

+ **Explode**

  + **explode** - default case which is the same as `explodeCustomized(30.0)`
    
  + **explodeCustomized(_ pieceWidth: CGFloat)** - default explode piece width is 30.0.

<table>
    <tr>
<!--        <td><img src="image/animations/Explode/width30.gif"></td>-->
        <td><img src="image/animations/Explode/width10.gif"></td>
        <td><img src="image/animations/Explode/width45.gif"></td>
        <td><img src="image/animations/Explode/width60.gif"></td>
    </tr>
        <tr>
<!--        <th>explode piece width is 30.0</th>-->
        <th>explode piece width is 10.0</th>
        <th>explode piece width is 45.0</th>
        <th>explode piece width is 60.0</th>
    </tr>
</table>

****

+ **Fence**

  + **fence** - default case which is the same as `fenceCustomized(verticalLeft, width: 20.0)`
    
  + **fenceCustomized(_ type: JWStackTransitionAnimationFenceType, width: CGFloat)** - default animation type is `verticalLeft`, default fence width is `20.0`.

<table>
    <tr>
        <td><img src="image/animations/Fence/verLeft.gif"></td>
        <td><img src="image/animations/Fence/verRight.gif"></td>
        <td><img src="image/animations/Fence/verCross.gif"></td>
    </tr>
        <tr>
        <th>verticalLeft and width is 20.0</th>
        <th>verticalRight and width is 5.0</th>
        <th>verticalCross and width is 10.0</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Fence/horTop.gif"></td>
        <td><img src="image/animations/Fence/horBottom.gif"></td>
        <td><img src="image/animations/Fence/horCross.gif"></td>
    </tr>
        <tr>
        <th>horizontalTop and width is 15.0</th>
        <th>horizontalBottom and width is 20.0</th>
        <th>horizontalCross and width is 25.0</th>
    </tr>
</table>

****

+ **Flip**

  + **flip** - default case which is the same as `flipCustomized(.fromLeftToRight)`
    
  + **flipCustomized(_ type: JWStackTransitionAnimationFoldType)** - default animation type is `fromLeftToRight`.

<table>
    <tr>
        <td><img src="image/animations/Flip/fromLeftToRight.gif"></td>
        <td><img src="image/animations/Flip/fromRightToLeft.gif"></td>
    </tr>
        <tr>
        <th>fromLeftToRight</th>
        <th>fromRightToLeft</th>
    </tr>
</table>

****

+ **Fold**

  + **fold** - default case which is the same as `foldCustomized(.fromLeftToRight, foldNum: 2)`
    
  + **foldCustomized(_ type: JWStackTransitionAnimationFoldType, foldNum: Int)** - default animation type is `fromLeftToRight`, default fold number is `2`.

<table>
    <tr>
        <td><img src="image/animations/Fold/lr2.gif"></td>
        <td><img src="image/animations/Fold/lr4.gif"></td>
        <td><img src="image/animations/Fold/rl6.gif"></td>
        <td><img src="image/animations/Fold/rl8.gif"></td>
    </tr>
        <tr>
        <th>fromLeftToRight and fold number is 2</th>
        <th>fromLeftToRight and fold number is 4</th>
        <th>fromRightToLeft and fold number is 6</th>
        <th>fromRightToLeft and fold number is 8</th>
    </tr>
</table>

****

## Tree

Directory structure of SFStyleKit:

<div align="center" >
  <img width="85%" src="image/tree.png" />
</div>

also, [DeepWiki](https://deepwiki.com/Sfh03031/SFStyleKit/) may help you better understand SFStyleKit

## Requirements

* iOS 12.0 or later
* Swift 5.9.2
* Xcode 15.1

## Installation

JWStackTransition is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

pod 'JWStackTransition', :git => 'https://github.com/Sfh03031/JWStackTransition.git'

```

## Usage

## Change log

## Author

Sfh03031, sfh894645252@163.com

## License

JWStackTransition is available under the MIT license. See the LICENSE file for more info.
