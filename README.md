# JWStackTransition

[![CI Status](https://img.shields.io/travis/Sfh03031/JWStackTransition.svg?style=flat)](https://travis-ci.org/Sfh03031/JWStackTransition)
[![Version](https://img.shields.io/cocoapods/v/JWStackTransition.svg?style=flat)](https://cocoapods.org/pods/JWStackTransition)
[![License](https://img.shields.io/cocoapods/l/JWStackTransition.svg?style=flat)](https://cocoapods.org/pods/JWStackTransition)
[![Platform](https://img.shields.io/cocoapods/p/JWStackTransition.svg?style=flat)](https://cocoapods.org/pods/JWStackTransition)

## Introduction

JWStackTransition is a library that provides transition animations for navigation controllers, offering various transition effects such as clocks, fences, flips, and folds. 

Its principle is provide transition classes that comply with the `UIViewControlAnimatedTransitioning` protocol for the delegate method `navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController)` of UINavigationController. 

It currently has many different kind of transition animation types, most of them can be customized.

This library was inspired by [VCTransitionsLibrary](https://github.com/ColinEberhardt/VCTransitionsLibrary) and [RetroTransition](https://github.com/wcgray/RetroTransition)

## All animation types and some examples

The library currently contains the following animations, contents:

  * [AntiClockWise](#AntiClockWise)
  * [Barrier](#Barrier)
  * [ClockWise](#ClockWise)
  * [Cube](#Cube)
  * [Door](#Door)
  * [Expand](#Expand)
  * [Explode](#Explode)
  * [Fence](#Fence)
  * [Flip](#Flip)
  * [Fold](#Fold)
  * [MultiCircle](#MultiCircle)
  * [Multinest](#Multinest)
  * [NatGeo](#NatGeo)
  * [Official](#Official)
  * [Pan](#Pan)
  * [Particle](#Particle)
  * [Puzzle](#Puzzle)
  * [Rectangler](#Rectangler)
  * [Roll](#Roll)
  * [Rotate](#Rotate)
  * [Serrate](#Serrate)
  * [ShiftLine](#ShiftLine)
  * [Shrink](#Shrink)
  * [Split](#Split)
  * [Swing](#Swing)
  * [TiledFlip](#TiledFlip)

### <a id="AntiClockWise"></a>AntiClockWise

  + **antiClockWise** - default case which is the same as `antiClockWiseCustomized(1.5)`.
    
  + **antiClockWiseCustomized(_ startAngle: Double)** - default animation start angle is `1.5`, angle range is `[0.0, 2.0]`.


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

### <a id="Barrier"></a>Barrier

  + **barrier** - default case which is the same as `barrierCustomized(.toTop, width: 20.0)`.
  
  + **barrierCustomized(_ type: JWStackTransitionAnimationBarrierFadeDirectionType, width: CGFloat)** - default animation type is `toTop`, default barrier width is `20.0`.


<table>
    <tr>
        <td><img src="image/animations/Barrier/default.gif"></td>
        <td><img src="image/animations/Barrier/custom_toLeft.gif"></td>
        <td><img src="image/animations/Barrier/custom_toRight.gif"></td>
    </tr>
    <tr>
        <th>toTop, width is 20</th>
        <th>toLeft, width is 5</th>
        <th>toRight, width is 10</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Barrier/custom_toBottom.gif"></td>
        <td><img src="image/animations/Barrier/custom_toVerticalCenter.gif"></td>
        <td><img src="image/animations/Barrier/custom_toHorizontalCenter.gif"></td>
    </tr>
    <tr>
        <th>toBottom, width is 15</th>
        <th>toVerticalCenter, width is 20</th>
        <th>toHorizontalCenter, width is 25</th>
    </tr>
</table>

****

### <a id="ClockWise"></a>ClockWise

  + **clockWise** - default case which is the same as `clockWiseCustomized(0.5)`.
    
  + **clockWiseCustomized(_ startAngle: Double)** - default animation start angle is `0.5`, angle range is `[0.0, 2.0]`.


<table>
    <tr>
        <td><img src="image/animations/ClockWise/custom_00.gif"></td>
        <td><img src="image/animations/ClockWise/custom_05.gif"></td>
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

### <a id="Cube"></a>Cube

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

### <a id="Door"></a>Door

  + **door** - default case which is the same as `doorCustomized(.horizontalOpen, scale: 0.8)`
    
  + **doorCustomized(_ type: JWStackTransitionAnimationDoorType, scale: CGFloat?)** - default animation case is `horizontalOpen`, default animation scale is `0.8` and range is `(0.0, 1.0]`.


<table>
    <tr>
        <td><img src="image/animations/Door/horOpen.gif"></td>
        <td><img src="image/animations/Door/horClose.gif"></td>
        <td><img src="image/animations/Door/verOpen.gif"></td>
    </tr>
    <tr>
        <th>horizontalOpen, scale is 0.8</th>
        <th>horizontalClose, scale is 0.6</th>
        <th>verticalOpen, scale is 0.4</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Door/verClose.gif"></td>
        <td><img src="image/animations/Door/horizontal.gif"></td>
        <td><img src="image/animations/Door/vertical.gif"></td>
    </tr>
    <tr>
        <th>verticalClose, scale is 0.2</th>
        <th>horizontal, scale is nil</th>
        <th>vertical, scale is nil</th>
    </tr>
</table>

****

### <a id="Expand"></a>Expand

  + **expand** - default case which is the same as `expandCustomized(.zero)`
    
  + **expandCustomized(_ fromRect: CGRect)** - default from rect is `CGRect.zero`.
  
  
  ```
  let a = UIScreen.main.bounds.width
  let b = UIScreen.main.bounds.height
  
  let c = a / 2
  let d = b / 2
  ```
  
  
<table>
    <tr>
        <td><img src="image/animations/Expand/1.gif"></td>
        <td><img src="image/animations/Expand/2.gif"></td>
        <td><img src="image/animations/Expand/3.gif"></td>
        <td><img src="image/animations/Expand/4.gif"></td>
    </tr>
    <tr>
        <th>x: 0, y: 0, width: 0, height: 0</th>
        <th>x: a, y: 0, width: 0, height: 0</th>
        <th>x: a, y: b, width: 0, height: 0</th>
        <th>x: 0, y: b, width: 0, height: 0</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Expand/5.gif"></td>
        <td><img src="image/animations/Expand/6.gif"></td>
        <td><img src="image/animations/Expand/7.gif"></td>
        <td><img src="image/animations/Expand/8.gif"></td>
    </tr>
    <tr>
        <th>x: c, y: 0, width: 0, height: 0</th>
        <th>x: a, y: d, width: 0, height: 0</th>
        <th>x: c, y: b, width: 0, height: 0</th>
        <th>x: 0, y: d, width: 0, height: 0</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Expand/9.gif"></td>
        <td><img src="image/animations/Expand/10.gif"></td>
        <td><img src="image/animations/Expand/11.gif"></td>
        <td><img src="image/animations/Expand/12.gif"></td>
    </tr>
    <tr>
        <th>x: c, y: d, width: 0, height: 0</th>
        <th>x: c-50, y: d-50, width: 100, height: 100</th>
        <th>x: a*2, y: b*2, width: 100, height: 100</th>
        <th>x: -a, y: -b, width: 100, height: 100</th>
    </tr>
</table>

****

### <a id="Explode"></a>Explode

  + **explode** - default case which is the same as `explodeCustomized(CGSize(width: 50, height: 100))`
    
  + **explodeCustomized(_ pieceSize: CGSize)** - default explode piece width is 50 and height is 100.
  
  
  ```
  let aa = UIScreen.main.bounds.width / 2
  let bb = UIScreen.main.bounds.height / 2
  ```
  
  
<table>
    <tr>
        <td><img src="image/animations/Explode/0.gif"></td>
        <td><img src="image/animations/Explode/1.gif"></td>
        <td><img src="image/animations/Explode/2.gif"></td>
        <td><img src="image/animations/Explode/3.gif"></td>
    </tr>
    <tr>
        <th>width is 50, height is 100</th>
        <th>width is 10, height is 10</th>
        <th>width is aa, height is 10</th>
        <th>width is 10, height is bb</th>
    </tr>
</table>

****

### <a id="Fence"></a>Fence

  + **fence** - default case which is the same as `fenceCustomized(.verticalLeft, width: 20.0)`
    
  + **fenceCustomized(_ type: JWStackTransitionAnimationFenceType, width: CGFloat)** - default animation type is `verticalLeft`, default fence width is `20.0`.


<table>
    <tr>
        <td><img src="image/animations/Fence/verLeft.gif"></td>
        <td><img src="image/animations/Fence/verRight.gif"></td>
        <td><img src="image/animations/Fence/verCross.gif"></td>
    </tr>
    <tr>
        <th>verticalLeft, width is 20.0</th>
        <th>verticalRight, width is 5.0</th>
        <th>verticalCross, width is 10</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Fence/horTop.gif"></td>
        <td><img src="image/animations/Fence/horBottom.gif"></td>
        <td><img src="image/animations/Fence/horCross.gif"></td>
    </tr>
    <tr>
        <th>horizontalTop, width is 15.0</th>
        <th>horizontalBottom, width is 20</th>
        <th>horizontalCross, width is 25</th>
    </tr>
</table>

****

### <a id="Flip"></a>Flip

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

### <a id="Fold"></a>Fold

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
        <th>fromLeftToRight, fold number is 2</th>
        <th>fromLeftToRight, fold number is 4</th>
        <th>fromRightToLeft, fold number is 6</th>
        <th>fromRightToLeft, fold number is 8</th>
    </tr>
</table>

****

### <a id="MultiCircle"></a>MultiCircle

  + **multiCircle** - default case which is the same as `multiCircleCustomized(20.0)`
    
  + **multiCircleCustomized(_ diameter: CGFloat)** - default single circle diameter is `20.0`, diameter range is `(0, 100]`.


<table>
    <tr>
        <td><img src="image/animations/MultiCircle/diameter20.gif"></td>
        <td><img src="image/animations/MultiCircle/diameter40.gif"></td>
        <td><img src="image/animations/MultiCircle/diameter60.gif"></td>
        <td><img src="image/animations/MultiCircle/diameter5.gif"></td>
    </tr>
    <tr>
        <th>diameter is 20.0</th>
        <th>diameter is 40.0</th>
        <th>diameter is 60.0</th>
        <th>diameter is 5.0</th>
    </tr>
</table>

****

### <a id="Multinest"></a>Multinest

  + **multinest**
  
  
<div align="left" >
  <img width="20%" src="image/animations/Multinest/default.gif" />
</div>
  
****

### <a id="NatGeo"></a>NatGeo

  + **natGeo** - default case which is the same as `natGeoCustomized(.geoLeft)`
    
  + **natGeoCustomized(_ type: JWStackTransitionAnimationNatGeoType)** - default animation type is `geoLeft`.


<table>
    <tr>
        <td><img src="image/animations/NatGeo/geoLeft.gif"></td>
        <td><img src="image/animations/NatGeo/geoRight.gif"></td>
    </tr>
    <tr>
        <th>geoLeft</th>
        <th>geoRight</th>
    </tr>
</table>

****

### <a id="Official"></a>Official

  + **official** - default case which is the same as `officialCustomized(.crossDissolve)`
    
  + **officialCustomized(_ type: JWStackTransitionAnimationOfficialType)** - default animation type is `crossDissolve`.


<table>
    <tr>
        <td><img src="image/animations/Official/crossDissolve.gif"></td>
        <td><img src="image/animations/Official/curlUp.gif"></td>
        <td><img src="image/animations/Official/curlDown.gif"></td>
    </tr>
    <tr>
        <th>crossDissolve</th>
        <th>curlUp</th>
        <th>curlDown</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Official/flipFromLeft.gif"></td>
        <td><img src="image/animations/Official/flipFromRight.gif"></td>
        <td><img src="image/animations/Official/flipFromTop.gif"></td>
        <td><img src="image/animations/Official/flipFromBottom.gif"></td>
    </tr>
    <tr>
        <th>flipFromLeft</th>
        <th>flipFromRight</th>
        <th>flipFromTop</th>
        <th>flipFromBottom</th>
    </tr>
</table>

****

### <a id="Pan"></a>Pan

  + **pan** - default case which is the same as `panCustomized(.panLeft)`
    
  + **panCustomized(_ type: JWStackTransitionAnimationPanType)** - default animation type is `panLeft`.


<table>
    <tr>
        <td><img src="image/animations/Pan/panLeft.gif"></td>
        <td><img src="image/animations/Pan/panRight.gif"></td>
        <td><img src="image/animations/Pan/panTop.gif"></td>
        <td><img src="image/animations/Pan/panBottom.gif"></td>
    </tr>
    <tr>
        <th>panLeft</th>
        <th>panRight</th>
        <th>panTop</th>
        <th>panBottom</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Pan/panLeftWithShake.gif"></td>
        <td><img src="image/animations/Pan/panRightWithShake.gif"></td>
        <td><img src="image/animations/Pan/panTopWithShake.gif"></td>
        <td><img src="image/animations/Pan/panBottomWithShake.gif"></td>
    </tr>
    <tr>
        <th>panLeftWithShake</th>
        <th>panRightWithShake</th>
        <th>panTopWithShake</th>
        <th>panBottomWithShake</th>
    </tr>
</table>

****

### <a id="Pan"></a>Particle

  + **particle** - default case which is the same as `particleCustomized(.zero, size: CGSize(width: 20, height: 20))`
    
  + **particleCustomized(_ from: CGPoint, size: CGSize)** - default particle ejected from point is `CGPoint.zero`, particle width is `20` and height is `20`.
  
  
  ```
  let aa = UIScreen.main.bounds.width / 2
  let bb = UIScreen.main.bounds.height / 2
  ```


<table>
    <tr>
        <td><img src="image/animations/Particle/0.gif"></td>
        <td><img src="image/animations/Particle/1.gif"></td>
        <td><img src="image/animations/Particle/2.gif"></td>
        <td><img src="image/animations/Particle/3.gif"></td>
    </tr>
    <tr>
        <th>width is 20, height is 20</th>
        <th>width is 10, height is 20</th>
        <th>width is 20, height is 10</th>
        <th>width is 10, height is 10</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Particle/4.gif"></td>
        <td><img src="image/animations/Particle/5.gif"></td>
        <td><img src="image/animations/Particle/6.gif"></td>
        <td><img src="image/animations/Particle/7.gif"></td>
    </tr>
    <tr>
        <th>width is 5, height is 20</th>
        <th>width is 50, height is 50</th>
        <th>width is aa, height is 15</th>
        <th>width is 15, height is bb</th>
    </tr>
</table>

****

### <a id="Pan"></a>Puzzle

  + **puzzle** - default case which is the same as `puzzleCustomized(.random, column: 5, row: 10)`
    
  + **puzzleCustomized(_ type: JWStackTransitionAnimationPuzzleType, column: Int, row: Int)** - default animation type is `random`, column is `5` and row is `10`.


<table>
    <tr>
        <td><img src="image/animations/Puzzle/random.gif"></td>
        <td><img src="image/animations/Puzzle/fromLeft.gif"></td>
        <td><img src="image/animations/Puzzle/fromRight.gif"></td>
        <td><img src="image/animations/Puzzle/fromTop.gif"></td>
        <td><img src="image/animations/Puzzle/fromBottom.gif"></td>
    </tr>
    <tr>
        <th>random</th>
        <th>fromLeft</th>
        <th>fromRight</th>
        <th>fromTop</th>
        <th>fromBottom</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Puzzle/fromTopLeft.gif"></td>
        <td><img src="image/animations/Puzzle/fromTopRight.gif"></td>
        <td><img src="image/animations/Puzzle/fromBottomlEFT.gif"></td>
        <td><img src="image/animations/Puzzle/fromBottomRight.gif"></td>
    </tr>
    <tr>
        <th>fromTopLeft</th>
        <th>fromTopRight</th>
        <th>fromBottomLeft</th>
        <th>fromBottomRight</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Puzzle/horizontal.gif"></td>
        <td><img src="image/animations/Puzzle/vertical.gif"></td>
        <td><img src="image/animations/Puzzle/fromHorizontalBoth.gif"></td>
        <td><img src="image/animations/Puzzle/fromVerticalBoth.gif"></td>
        <td><img src="image/animations/Puzzle/quadrant.gif"></td>
    </tr>
    <tr>
        <th>horizontal</th>
        <th>vertical</th>
        <th>fromHorBoth</th>
        <th>fromVerBoth</th>
        <th>quadrant</th>
    </tr>
</table>

****

### <a id="Rectangler"></a>Rectangler

  + **rectangler** - default case which is the same as `rectanglerCustomized(.waveIn)`
    
  + **rectanglerCustomized(_ wave: JWStackTransitionAnimationRectanglerWave)** - default animation type is `waveIn`.


<table>
    <tr>
        <td><img src="image/animations/Rectangler/waveIn.gif"></td>
        <td><img src="image/animations/Rectangler/waveOut.gif"></td>
    </tr>
    <tr>
        <th>waveIn</th>
        <th>waveOut</th>
    </tr>
</table>

****

### <a id="Roll"></a>Roll

  + **roll** - default case which is the same as `rollCustomized(.y)`
    
  + **rollCustomized(_ axis: JWStackTransitionAnimationRollAxis)** - default animation roll axis is `y`.


<table>
    <tr>
        <td><img src="image/animations/Roll/x.gif"></td>
        <td><img src="image/animations/Roll/y.gif"></td>
        <td><img src="image/animations/Roll/z.gif"></td>
    </tr>
    <tr>
        <th>x</th>
        <th>y</th>
        <th>z</th>
    </tr>
</table>

****

### <a id="Rotate"></a>Rotate

  + **rotate** - default case which is the same as `rotateCustomized(.clockWise, rotateAngle: 0.99)`
    
  + **rotateCustomized(_ type: JWStackTransitionAnimationRotateType, rotateAngle: Double)** - default animation rotate type is `clockWise`, default rotate angle is `0.99`, angle range is `(0.0, 1.0)`.
  

<table>
    <tr>
        <td><img src="image/animations/Rotate/clockWise099.gif"></td>
        <td><img src="image/animations/Rotate/clockWise050.gif"></td>
        <td><img src="image/animations/Rotate/antiClockWise099.gif"></td>
        <td><img src="image/animations/Rotate/antiClockWise050.gif"></td>
    </tr>
    <tr>
        <th>clockWise, rotate angle is 0.99</th>
        <th>clockWise, rotate angle is 0.5</th>
        <th>antiClockWise, rotate angle is 0.99</th>
        <th>antiClockWise, rotate angle is 0.5</th>
    </tr>
</table>
  
****

### <a id="Rotate"></a>Serrate

  + **serrate** - default case which is the same as `serrateCustomized(.horizontal, count: 7)`
    
  + **serrateCustomized(_ type: JWStackTransitionAnimationSerrateType, count: Int)** - default animation type is `horizontal` and default serrate count is `7`.
  
  
<table>
    <tr>
        <td><img src="image/animations/Serrate/0.gif"></td>
        <td><img src="image/animations/Serrate/1.gif"></td>
        <td><img src="image/animations/Serrate/2.gif"></td>
        <td><img src="image/animations/Serrate/3.gif"></td>
    </tr>
    <tr>
        <th>horizontal, serrate count is 7</th>
        <th>horizontal, serrate count is 20</th>
        <th>vertical, serrate count is 5</th>
        <th>vertical, serrate count is 10</th>
    </tr>
</table>
  
****

### <a id="ShiftLine"></a>ShiftLine

  + **shiftLine** - default case which is the same as `shiftLineCustomized(.toRight)`
    
  + **shiftLineCustomized(_ type: JWStackTransitionAnimationShiftLineType)** - default animation type is `toRight`.


<table>
    <tr>
        <td><img src="image/animations/ShiftLine/toRight.gif"></td>
        <td><img src="image/animations/ShiftLine/toTop.gif"></td>
        <td><img src="image/animations/ShiftLine/toBottom.gif"></td>
        <td><img src="image/animations/ShiftLine/toLeft.gif"></td>
    </tr>
    <tr>
        <th>toRight</th>
        <th>toTop</th>
        <th>toBottom</th>
        <th>toLeft</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/ShiftLine/toTopRight.gif"></td>
        <td><img src="image/animations/ShiftLine/toBottomRight.gif"></td>
        <td><img src="image/animations/ShiftLine/toBottomLeft.gif"></td>
        <td><img src="image/animations/ShiftLine/toTopLeft.gif"></td>
    </tr>
    <tr>
        <th>toTopRight</th>
        <th>toBottomRight</th>
        <th>toBottomLeft</th>
        <th>toTopLeft</th>
    </tr>
</table>

****

### <a id="Shrink"></a>Shrink

  + **shrink** - default case which is the same as `shrinkCustomized(.zero)`
    
  + **shrinkCustomized(_ fromRect: CGRect)** - default from rect is `CGRect.zero`.
  
  
  ```
  let a = UIScreen.main.bounds.width
  let b = UIScreen.main.bounds.height
  
  let c = a / 2
  let d = b / 2
  ```


<table>
    <tr>
        <td><img src="image/animations/Shrink/1.gif"></td>
        <td><img src="image/animations/Shrink/2.gif"></td>
        <td><img src="image/animations/Shrink/3.gif"></td>
        <td><img src="image/animations/Shrink/4.gif"></td>
    </tr>
    <tr>
        <th>x: 0, y: 0, width: 0, height: 0</th>
        <th>x: a, y: 0, width: 0, height: 0</th>
        <th>x: a, y: b, width: 0, height: 0</th>
        <th>x: 0, y: b, width: 0, height: 0</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Shrink/5.gif"></td>
        <td><img src="image/animations/Shrink/6.gif"></td>
        <td><img src="image/animations/Shrink/7.gif"></td>
        <td><img src="image/animations/Shrink/8.gif"></td>
    </tr>
    <tr>
        <th>x: c, y: 0, width: 0, height: 0</th>
        <th>x: a, y: d, width: 0, height: 0</th>
        <th>x: c, y: b, width: 0, height: 0</th>
        <th>x: 0, y: d, width: 0, height: 0</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Shrink/9.gif"></td>
        <td><img src="image/animations/Shrink/10.gif"></td>
        <td><img src="image/animations/Shrink/11.gif"></td>
        <td><img src="image/animations/Shrink/12.gif"></td>
    </tr>
    <tr>
        <th>x: c, y: d, width: 0, height: 0</th>
        <th>x: c-50, y: d-50, width: 100, height: 100</th>
        <th>x: a*2, y: b*2, width: 100, height: 100</th>
        <th>x: -a, y: -b, width: 100, height: 100</th>
    </tr>
</table>

****

### <a id="Split"></a>Split

  + **split** - default case which is the same as `splitCustomized(.horizontal)`
    
  + **splitCustomized(_ type: JWStackTransitionAnimationSplitType)** - default split type is `horizontal`.


<table>
    <tr>
        <td><img src="image/animations/Split/horizontal.gif"></td>
        <td><img src="image/animations/Split/vertical.gif"></td>
        <td><img src="image/animations/Split/diamondHorizontal.gif"></td>
        <td><img src="image/animations/Split/diamondVertical.gif"></td>
    </tr>
    <tr>
        <th>horizontal</th>
        <th>vertical</th>
        <th>diamondHorizontal</th>
        <th>diamondVertical</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/Split/cross.gif"></td>
        <td><img src="image/animations/Split/leftDiagonal.gif"></td>
        <td><img src="image/animations/Split/rightDiagonal.gif"></td>
        <td><img src="image/animations/Split/crossDiagonal.gif"></td>
    </tr>
    <tr>
        <th>cross</th>
        <th>leftDiagonal</th>
        <th>rightDiagonal</th>
        <th>crossDiagonal</th>
    </tr>
</table>

****

### <a id="Swing"></a>Swing

  + **swing** - default case which is the same as `swingCustomized(.left)`
    
  + **swingCustomized(_ edge: JWStackTransitionAnimationRectEdge)** - default animation rect edge is `left`.


<table>
    <tr>
        <td><img src="image/animations/Swing/left.gif"></td>
        <td><img src="image/animations/Swing/right.gif"></td>
        <td><img src="image/animations/Swing/top.gif"></td>
        <td><img src="image/animations/Swing/bottom.gif"></td>
    </tr>
    <tr>
        <th>left</th>
        <th>right</th>
        <th>top</th>
        <th>bottom</th>
    </tr>
</table>

****

### <a id="TiledFlip"></a>TiledFlip

  + **tiledFlip** - default case which is the same as `tiledFlipCustomized(.flipFromRight, tiledRow: 10, tiledColumn: 5)`
    
  + **tiledFlipCustomized(_ type: JWStackTransitionAnimationOfficialType, tiledRow: Int, tiledColumn: Int)** - default animation type is `flipFromRight`, default tiled row is `10` and range is `(0, 20]`, default tiled column is `5` and range is `(0, 10]`.


<table>
    <tr>
        <td><img src="image/animations/TiledFlip/flipFromRight.gif"></td>
        <td><img src="image/animations/TiledFlip/flipFromLeft.gif"></td>
        <td><img src="image/animations/TiledFlip/flipFromTop.gif"></td>
        <td><img src="image/animations/TiledFlip/flipFromBottom.gif"></td>
    </tr>
    <tr>
        <th>flipFromRight</th>
        <th>flipFromLeft</th>
        <th>flipFromTop</th>
        <th>flipFromBottom</th>
    </tr>
</table>

<table>
    <tr>
        <td><img src="image/animations/TiledFlip/crossDissolve.gif"></td>
        <td><img src="image/animations/TiledFlip/curlUp.gif"></td>
        <td><img src="image/animations/TiledFlip/curlDown.gif"></td>
    </tr>
    <tr>
        <th>crossDissolve</th>
        <th>curlUp</th>
        <th>curlDown</th>
    </tr>
</table>

****

## Tree

Directory structure of JWStackTransition:

<div align="center" >
  <img width="85%" src="image/tree.png" />
</div>

also, [DeepWiki](https://deepwiki.com/Sfh03031/JWStackTransition/) may help you better understand JWStackTransition.

## Requirements

* iOS 12.0 or later
* Swift 5.9.2
* Xcode 15.1

## Installation

JWStackTransition is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

pod 'JWStackTransition'

```
## Usage

Install and import JWStackTransition

```swift

import JWStackTransition

```

JWStackTransition extends the `push` and `pop` methods of UINavigationController, so it can be used as follows:

```swift

/// push
self.navigationController?.push(vc, type: type, duration: 1.0)

#another way
// self.navigationController?.push(vc, transition: JWStackTransition(type: type, duration: 1.0))

/// pop
self.navigationController?.pop(.antiClockWise, duration: 1.0)

#another way
self.navigationController?.pop(JWStackTransition(type: .antiClockWise, duration: 1.0))

```

## Change log

2025.07.23, 0.1.6

- add new transition animations and fix bug

2025.07.08, 0.1.4

- add new transition animations

2025.05.20, 0.1.1

- Initial version

## Contributing

Please make an issue or pull request if you have any request.

Bug reports, Documentation, or tests, are always welcome as well.

## Author

Sfh03031, sfh894645252@163.com

## License

JWStackTransition is available under the MIT license. See the LICENSE file for more info.
