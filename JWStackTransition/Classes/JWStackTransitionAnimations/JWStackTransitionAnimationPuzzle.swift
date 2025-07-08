//
//  JWStackTransitionAnimationPuzzle.swift
//  Pods
//
//  Created by sfh on 2025/7/1.
//

#if canImport(UIKit)

import UIKit

public class JWStackTransitionAnimationPuzzle: JWStackTransitionAnimationDelegate {
    
    private var type: JWStackTransitionAnimationPuzzleType = .random
    private var column: Int = 5 // animation piece column count
    private var row: Int = 10 // animation piece row count
    
    init(_ type: JWStackTransitionAnimationPuzzleType, column: Int, row: Int) {
        self.type = type
        self.column = column
        self.row = row
    }
    
    func setUpAnimation(duration: TimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to),
              let toShot = toView.viewShot() else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let tempView = UIView(frame: containerView.bounds)
        containerView.addSubview(tempView)
    
        let pieceW = toView.frame.width / CGFloat(self.column)
        let pieceH = toView.frame.height / CGFloat(self.row)
        for i in 0..<self.column {
            for j in 0..<self.row {
                let x = pieceW * CGFloat(i)
                let y = pieceH * CGFloat(j)
                
                let tiledRect = CGRect(x: x, y: y, width: pieceW, height: pieceH)
                
                guard let toCGImg = toShot.cgImage,
                      let toImgRef = toCGImg.cropping(to: CGRect(x: toShot.scale * tiledRect.origin.x, y: toShot.scale * tiledRect.origin.y, width: toShot.scale * tiledRect.width, height: toShot.scale * tiledRect.height)) else {
                    print("cropping image failed")
                    return
                }
                
                // create a UIImageView for the piece
                let pieceImgView = UIImageView(image: UIImage(cgImage: toImgRef))
                pieceImgView.frame = tiledRect
                pieceImgView.clipsToBounds = true
                pieceImgView.alpha = 0.0
                tempView.addSubview(pieceImgView)
            }
        }
        
        // record original frames
        var originalFrames: [CGRect] = []
        for view in tempView.subviews {
            originalFrames.append(view.frame)
        }
        
        // shuffle the views
        let views = tempView.subviews
        let shuffledViews = views.shuffled()
        for (index, view) in shuffledViews.enumerated() {
            let x = view.frame.origin.x
            let y = view.frame.origin.y
            let w = view.frame.width
            let h = view.frame.height
            
            switch self.type {
            case .random:
                views[index].frame = view.frame
            case .horizontal:
                views[index].center = CGPoint(x: toView.frame.width / 2, y: y)
            case .vertical:
                views[index].center = CGPoint(x: x, y: toView.frame.height / 2)
            case .fromLeft:
                views[index].frame = CGRect(x: x - toView.frame.width, y: y, width: w, height: h)
            case .fromTop:
                views[index].frame = CGRect(x: x, y: y - toView.frame.height, width: w, height: h)
            case .fromRight:
                views[index].frame = CGRect(x: x + toView.frame.width, y: y, width: w, height: h)
            case .fromBottom:
                views[index].frame = CGRect(x: x, y: y + toView.frame.height, width: w, height: h)
            case .fromTopLeft:
                views[index].frame = CGRect(x: x - toView.frame.width, y: y - toView.frame.height, width: w, height: h)
            case .fromTopRight:
                views[index].frame = CGRect(x: x + toView.frame.width, y: y - toView.frame.height, width: w, height: h)
            case .fromBottomLeft:
                views[index].frame = CGRect(x: x - toView.frame.width, y: y + toView.frame.height, width: w, height: h)
            case .fromBottomRight:
                views[index].frame = CGRect(x: x + toView.frame.width, y: y + toView.frame.height, width: w, height: h)
            case .fromHorBoth:
                if x > toView.frame.width / 2 {
                    views[index].frame = CGRect(x: x + toView.frame.width / 2, y: y, width: w, height: h)
                } else {
                    views[index].frame = CGRect(x: x - toView.frame.width / 2, y: y, width: w, height: h)
                }
            case .fromVerBoth:
                if y > toView.frame.height / 2 {
                    views[index].frame = CGRect(x: x, y: y + toView.frame.height / 2, width: w, height: h)
                } else {
                    views[index].frame = CGRect(x: x, y: y - toView.frame.height / 2, width: w, height: h)
                }
            case .quadrant:
                if x <= toView.frame.width / 2 && y <= toView.frame.height / 2 {
                    views[index].center = CGPoint(x: toView.frame.width / 4, y: toView.frame.height / 4)
                } else if x > toView.frame.width / 2 && y <= toView.frame.height / 2 {
                    views[index].center = CGPoint(x: toView.frame.width / 4 * 3, y: toView.frame.height / 4)
                } else if x <= toView.frame.width / 2 && y > toView.frame.height / 2 {
                    views[index].center = CGPoint(x: toView.frame.width / 4, y: toView.frame.height / 4 * 3)
                } else if x > toView.frame.width / 2 && y > toView.frame.height / 2 {
                    views[index].center = CGPoint(x: toView.frame.width / 4 * 3, y: toView.frame.height / 4 * 3)
                }
            }
        }
        
        // animate the pieces
        for (index, view) in tempView.subviews.enumerated() {
            let random = Float(arc4random()) / Float(UInt32.max)
            let relative = Double(Float(duration * 0.5) * random)

            UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: relative, animations: {
                    view.alpha = 1
                })
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                    view.frame = originalFrames[index]
                })
            } completion: { finished in
                if finished {
                    tempView.removeFromSuperview()
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }
    }
}

#endif
