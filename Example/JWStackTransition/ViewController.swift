//
//  ViewController.swift
//  JWStackTransition
//
//  Created by Sfh03031 on 05/20/2025.
//  Copyright (c) 2025 Sfh03031. All rights reserved.
//

import UIKit
import JWStackTransition

struct Examples {
    var title: String
    var list: [ExampleItem]
    
    init(title: String, list: [ExampleItem]) {
        self.title = title
        self.list = list
    }
}

struct ExampleItem {
    var name: String
    var type: JWStackTransitionType
    
    init(name: String, type: JWStackTransitionType) {
        self.name = name
        self.type = type
    }
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let imgList = ["galleryImage01", "galleryImage02", "galleryImage03", "galleryImage04", "galleryImage05", "galleryImage06", "galleryImage07", "galleryImage08", "lightning1", "lightning2", "moon1", "moon2", "snow1", "snow2", "sun1", "sun2", "tornado1", "tornado2"]
    
    let dataList = [
        Examples(title: "AntiClockWise", list: [
            ExampleItem(name: "default, start angle is 1.5", type: .antiClockWise),
            ExampleItem(name: "start angle is 0.0", type: .antiClockWiseCustomized(0.0)),
            ExampleItem(name: "start angle is 0.5", type: .antiClockWiseCustomized(0.5)),
            ExampleItem(name: "start angle is 1.0", type: .antiClockWiseCustomized(1.0)),
            ExampleItem(name: "start angle is 2.0", type: .antiClockWiseCustomized(2.0))
        ]),
        Examples(title: "Barrier", list: [
            ExampleItem(name: "default, toTop and width is 20", type: .barrier),
            ExampleItem(name: "toLeft and width is 5", type: .barrierCustomized(.toLeft, width: 5)),
            ExampleItem(name: "toRight and width is 10", type: .barrierCustomized(.toRight, width: 10)),
            ExampleItem(name: "toBottom and width is 15", type: .barrierCustomized(.toBottom, width: 15)),
            ExampleItem(name: "toVerticalCenter and width is 20", type: .barrierCustomized(.toVerticalCenter, width: 20)),
            ExampleItem(name: "toHorizontalCenter and width is 25", type: .barrierCustomized(.toHorizontalCenter, width: 25)),
        ]),
        Examples(title: "ClockWise", list: [
            ExampleItem(name: "default, start angle is 0.5", type: .clockWise),
            ExampleItem(name: "start angle is 0.0", type: .clockWiseCustomized(0.0)),
            ExampleItem(name: "start angle is 1.0", type: .clockWiseCustomized(1.0)),
            ExampleItem(name: "start angle is 1.5", type: .clockWiseCustomized(1.5)),
            ExampleItem(name: "start angle is 2.0", type: .clockWiseCustomized(2.0))
        ]),
        Examples(title: "Cube", list: [
            ExampleItem(name: "default, fromLeftToRight", type: .cube),
            ExampleItem(name: "fromRightToLeft", type: .cubeCustomized(.fromRightToLeft)),
            ExampleItem(name: "fromTopToBottom", type: .cubeCustomized(.fromTopToBottom)),
            ExampleItem(name: "fromBottomToTop", type: .cubeCustomized(.fromBottomToTop))
        ]),
        Examples(title: "Door", list: [
            ExampleItem(name: "default, horizontalOpen and scale is 0.8", type: .door),
            ExampleItem(name: "horizontalClose and scale is 0.6", type: .doorCustomized(.horizontalClose, scale: 0.6)),
            ExampleItem(name: "verticalOpen and scale is 0.4", type: .doorCustomized(.verticalOpen, scale: 0.4)),
            ExampleItem(name: "verticalClose and scale is 0.2", type: .doorCustomized(.verticalClose, scale: 0.2)),
            ExampleItem(name: "horizontal", type: .doorCustomized(.horizontal, scale: nil)),
            ExampleItem(name: "vertical", type: .doorCustomized(.vertical, scale: nil)),
        ]),
        Examples(title: "Expand", list: [
            ExampleItem(name: "default, CGRect.zero", type: .expand),
            ExampleItem(name: "x: screenWidth, y: 0, width: 0, height: 0", type: .expandCustomized(CGRect(x: screenWidth, y: 0, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth, y: screenHeight, width: 0, height: 0", type: .expandCustomized(CGRect(x: screenWidth, y: screenHeight, width: 0, height: 0))),
            ExampleItem(name: "x: 0, y: screenHeight, width: 0, height: 0", type: .expandCustomized(CGRect(x: 0, y: screenHeight, width: 0, height: 0))),
            
            ExampleItem(name: "x: screenWidth / 2, y: 0, width: 0, height: 0", type: .expandCustomized(CGRect(x: screenWidth / 2, y: 0, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth, y: screenHeight / 2, width: 0, height: 0", type: .expandCustomized(CGRect(x: screenWidth, y: screenHeight / 2, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth / 2, y: screenHeight, width: 0, height: 0", type: .expandCustomized(CGRect(x: screenWidth / 2, y: screenHeight, width: 0, height: 0))),
            ExampleItem(name: "x: 0, y: screenHeight / 2, width: 0, height: 0", type: .expandCustomized(CGRect(x: 0, y: screenHeight / 2, width: 0, height: 0))),
            
            ExampleItem(name: "x: screenWidth / 2, y: screenHeight / 2, width: 0, height: 0", type: .expandCustomized(CGRect(x: screenWidth / 2, y: screenHeight / 2, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth / 2 - 50, y: screenHeight / 2 - 50, width: 100, height: 100", type: .expandCustomized(CGRect(x: screenWidth / 2 - 50, y: screenHeight / 2 - 50, width: 100, height: 100))),
            ExampleItem(name: "x: screenWidth * 2, y: screenHeight * 2, width: 100, height: 100", type: .expandCustomized(CGRect(x: screenWidth * 2, y: screenHeight * 2, width: 100, height: 100))),
            ExampleItem(name: "x: -screenWidth, y: -screenHeight, width: 100, height: 100", type: .expandCustomized(CGRect(x: -screenWidth, y: -screenHeight, width: 100, height: 100))),
        ]),
        Examples(title: "Explode", list: [
            ExampleItem(name: "default, explode piece width is 50 and height is 100", type: .explode),
            ExampleItem(name: "explode piece width is 10 and height is 10", type: .explodeCustomized(CGSizeMake(10, 20))),
            ExampleItem(name: "explode piece width is screenWidth / 2 and height is 10", type: .explodeCustomized(CGSizeMake(screenWidth / 2, 10))),
            ExampleItem(name: "explode piece width is 10 and height is screenHeight / 2", type: .explodeCustomized(CGSizeMake(10, screenHeight / 2))),
        ]),
        Examples(title: "Fence", list: [
            ExampleItem(name: "default, verticalLeft and width is 20", type: .fence),
            ExampleItem(name: "verticalRight and width is 5", type: .fenceCustomized(.verticalRight, width: 5.0)),
            ExampleItem(name: "verticalCross and width is 10", type: .fenceCustomized(.verticalCross, width: 10.0)),
            ExampleItem(name: "horizontalTop and width is 15", type: .fenceCustomized(.horizontalTop, width: 15.0)),
            ExampleItem(name: "horizontalBottom and width is 20", type: .fenceCustomized(.horizontalBottom, width: 20.0)),
            ExampleItem(name: "horizontalCross and width is 25", type: .fenceCustomized(.horizontalCross, width: 25.0)),
        ]),
        Examples(title: "Flip", list: [
            ExampleItem(name: "default, fromLeftToRight", type: .flip),
            ExampleItem(name: "fromRightToLeft", type: .flipCustomized(.fromRightToLeft))
        ]),
        Examples(title: "Fold", list: [
            ExampleItem(name: "default, fromLeftToRight and fold number is 2", type: .fold),
            ExampleItem(name: "fromLeftToRight and fold number is 4", type: .foldCustomized(.fromLeftToRight, foldNum: 4)),
            ExampleItem(name: "fromRightToLeft and fold number is 6", type: .foldCustomized(.fromRightToLeft, foldNum: 6)),
            ExampleItem(name: "fromRightToLeft and fold number is 8", type: .foldCustomized(.fromRightToLeft, foldNum: 8))
        ]),
        Examples(title: "MultiCircle", list: [
            ExampleItem(name: "default, diameter is 20.0", type: .multiCircle),
            ExampleItem(name: "diameter is 40.0", type: .multiCircleCustomized(40.0)),
            ExampleItem(name: "diameter is 60.0", type: .multiCircleCustomized(60.0)),
            ExampleItem(name: "diameter is 5.0", type: .multiCircleCustomized(5.0)),
        ]),
        Examples(title: "Multinest", list: [
            ExampleItem(name: "default", type: .multinest)
        ]),
        Examples(title: "NatGeo", list: [
            ExampleItem(name: "default, geoLeft", type: .natGeo),
            ExampleItem(name: "geoRight", type: .natGeoCustomized(.geoRight)),
        ]),
        Examples(title: "Official", list: [
            ExampleItem(name: "default, crossDissolve", type: .official),
            ExampleItem(name: "curlUp", type: .officialCustomized(.curlUp)),
            ExampleItem(name: "curlDown", type: .officialCustomized(.curlDown)),
            ExampleItem(name: "flipFromLeft", type: .officialCustomized(.flipFromLeft)),
            ExampleItem(name: "flipFromRight", type: .officialCustomized(.flipFromRight)),
            ExampleItem(name: "flipFromTop", type: .officialCustomized(.flipFromTop)),
            ExampleItem(name: "flipFromBottom", type: .officialCustomized(.flipFromBottom)),
        ]),
        Examples(title: "Pan", list: [
            ExampleItem(name: "default, panLeft", type: .pan),
            ExampleItem(name: "panRight", type: .panCustomized(.panRight)),
            ExampleItem(name: "panTop", type: .panCustomized(.panTop)),
            ExampleItem(name: "panBottom", type: .panCustomized(.panBottom)),
            ExampleItem(name: "panLeftWithShake", type: .panCustomized(.panLeftWithShake)),
            ExampleItem(name: "panRightWithShake", type: .panCustomized(.panRightWithShake)),
            ExampleItem(name: "panTopWithShake", type: .panCustomized(.panTopWithShake)),
            ExampleItem(name: "panBottomWithShake", type: .panCustomized(.panBottomWithShake)),
        ]),
        Examples(title: "Particle", list: [
            ExampleItem(name: "default, particle width is 20 and height is 20", type: .particle),
            ExampleItem(name: "particle width is 10 and height is 20", type: .particleCustomized(CGPoint(x: screenWidth / 4, y: screenHeight / 4), size: CGSize(width: 10, height: 20))),
            ExampleItem(name: "particle width is 20 and height is 10", type: .particleCustomized(CGPoint(x: screenWidth / 4 * 3, y: screenHeight / 4), size: CGSize(width: 20, height: 10))),
            ExampleItem(name: "particle width is 10 and height is 10", type: .particleCustomized(CGPoint(x: screenWidth / 4, y: screenHeight / 4 * 3), size: CGSize(width: 10, height: 10))),
            ExampleItem(name: "particle width is 5 and height is 20", type: .particleCustomized(CGPoint(x: screenWidth / 4 * 3, y: screenHeight / 4 * 3), size: CGSize(width: 5, height: 20))),
            ExampleItem(name: "particle width is 50 and height is 50", type: .particleCustomized(CGPoint(x: screenWidth / 2, y: screenHeight / 2), size: CGSize(width: 50, height: 50))),
            ExampleItem(name: "particle width is screenWidth / 2 and height is 15", type: .particleCustomized(CGPoint(x: screenWidth / 2, y: screenHeight / 2), size: CGSize(width: screenWidth / 2, height: 15))),
            ExampleItem(name: "particle width is 15 and height is screenHeight / 2", type: .particleCustomized(CGPoint(x: screenWidth / 2, y: screenHeight / 2), size: CGSize(width: 15, height: screenHeight / 2)))
        ]),
        Examples(title: "Puzzle", list: [
            ExampleItem(name: "default, random, column is 5 and row is 10", type: .puzzle),
            ExampleItem(name: "fromLeft, column is 20 and row is 60", type: .puzzleCustomized(.fromLeft, column: 20, row: 60)),
            ExampleItem(name: "fromTop, column is 10 and row is 120", type: .puzzleCustomized(.fromTop, column: 10, row: 120)),
            ExampleItem(name: "fromRight, column is 50 and row is 50", type: .puzzleCustomized(.fromRight, column: 50, row: 50)),
            ExampleItem(name: "fromBottom, column is 40 and row is 20", type: .puzzleCustomized(.fromBottom, column: 40, row: 20)),
            ExampleItem(name: "fromTopLeft, column is 30 and row is 80", type: .puzzleCustomized(.fromTopLeft, column: 30, row: 80)),
            ExampleItem(name: "fromTopRight, column is 10 and row is 100", type: .puzzleCustomized(.fromTopRight, column: 10, row: 100)),
            ExampleItem(name: "fromBottomLeft, column is 80 and row is 10", type: .puzzleCustomized(.fromBottomLeft, column: 80, row: 10)),
            ExampleItem(name: "fromBottomRight, column is 100 and row is 100", type: .puzzleCustomized(.fromBottomRight, column: 100, row: 100)),
            ExampleItem(name: "horizontal, column is 60 and row is 20", type: .puzzleCustomized(.horizontal, column: 60, row: 20)),
            ExampleItem(name: "vertical, column is 2 and row is 60", type: .puzzleCustomized(.vertical, column: 2, row: 60)),
            ExampleItem(name: "fromHorBoth, column is 20 and row is 2", type: .puzzleCustomized(.fromHorBoth, column: 20, row: 2)),
            ExampleItem(name: "fromVerBoth, column is 10 and row is 20", type: .puzzleCustomized(.fromVerBoth, column: 10, row: 20)),
            ExampleItem(name: "quadrant, column is 10 and row is 20", type: .puzzleCustomized(.quadrant, column: 10, row: 20)),
        ]),
        Examples(title: "Rectangler", list: [
            ExampleItem(name: "default, waveIn", type: .rectangler),
            ExampleItem(name: "waveOut", type: .rectanglerCustomized(.waveOut)),
        ]),
        Examples(title: "Roll", list: [
            ExampleItem(name: "default, axis is y", type: .roll),
            ExampleItem(name: "axis is x", type: .rollCustomized(.x)),
            ExampleItem(name: "axis is z", type: .rollCustomized(.z)),
        ]),
        Examples(title: "Rotate", list: [
            ExampleItem(name: "default, clockWise and rotate angle is 0.99", type: .rotate),
            ExampleItem(name: "clockWise and rotate angle is 0.5", type: .rotateCustomized(.clockWise, rotateAngle: 0.5)),
            ExampleItem(name: "antiClockWise and rotate angle is 0.99", type: .rotateCustomized(.antiClockWise, rotateAngle: 0.99)),
            ExampleItem(name: "antiClockWise and rotate angle is 0.5", type: .rotateCustomized(.antiClockWise, rotateAngle: 0.5))
        ]),
        Examples(title: "Serrate", list: [
            ExampleItem(name: "default, horizontal and serrate count is 7", type: .serrate),
            ExampleItem(name: "horizontal and serrate count is 20", type: .serrateCustomized(.horizontal, count: 20)),
            ExampleItem(name: "vertical and serrate count is 5", type: .serrateCustomized(.vertical, count: 5)),
            ExampleItem(name: "vertical and serrate count is 10", type: .serrateCustomized(.vertical, count: 10)),
        ]),
        Examples(title: "ShiftLine", list: [
            ExampleItem(name: "default, toRight", type: .shiftLine),
            ExampleItem(name: "toTop", type: .shiftLineCustomized(.toTop)),
            ExampleItem(name: "toBottom", type: .shiftLineCustomized(.toBottom)),
            ExampleItem(name: "toLeft", type: .shiftLineCustomized(.toLeft)),
            ExampleItem(name: "toTopRight", type: .shiftLineCustomized(.toTopRight)),
            ExampleItem(name: "toBottomRight", type: .shiftLineCustomized(.toBottomRight)),
            ExampleItem(name: "toBottomLeft", type: .shiftLineCustomized(.toBottomLeft)),
            ExampleItem(name: "toTopLeft", type: .shiftLineCustomized(.toTopLeft)),
        ]),
        Examples(title: "Shrink", list: [
            ExampleItem(name: "default, CGRect.zero", type: .shrink),
            ExampleItem(name: "x: screenWidth, y: 0, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: screenWidth, y: 0, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth, y: screenHeight, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: screenWidth, y: screenHeight, width: 0, height: 0))),
            ExampleItem(name: "x: 0, y: screenHeight, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: 0, y: screenHeight, width: 0, height: 0))),
            
            ExampleItem(name: "x: screenWidth / 2, y: 0, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: screenWidth / 2, y: 0, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth, y: screenHeight / 2, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: screenWidth, y: screenHeight / 2, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth / 2, y: screenHeight, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: screenWidth / 2, y: screenHeight, width: 0, height: 0))),
            ExampleItem(name: "x: 0, y: screenHeight / 2, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: 0, y: screenHeight / 2, width: 0, height: 0))),
            
            ExampleItem(name: "x: screenWidth / 2, y: screenHeight / 2, width: 0, height: 0", type: .shrinkCustomized(CGRect(x: screenWidth / 2, y: screenHeight / 2, width: 0, height: 0))),
            ExampleItem(name: "x: screenWidth / 2 - 50, y: screenHeight / 2 - 50, width: 100, height: 100", type: .shrinkCustomized(CGRect(x: screenWidth / 2 - 50, y: screenHeight / 2 - 50, width: 100, height: 100))),
            ExampleItem(name: "x: screenWidth * 2, y: screenHeight * 2, width: 100, height: 100", type: .shrinkCustomized(CGRect(x: screenWidth * 2, y: screenHeight * 2, width: 100, height: 100))),
            ExampleItem(name: "x: -screenWidth, y: -screenHeight, width: 100, height: 100", type: .shrinkCustomized(CGRect(x: -screenWidth, y: -screenHeight, width: 100, height: 100))),
        ]),
        Examples(title: "Split", list: [
            ExampleItem(name: "default, horizontal", type: .split),
            ExampleItem(name: "vertical", type: .splitCustomized(.vertical)),
            ExampleItem(name: "diamondHorizontal", type: .splitCustomized(.diamondHorizontal)),
            ExampleItem(name: "diamondVertical", type: .splitCustomized(.diamondVertical)),
            ExampleItem(name: "cross", type: .splitCustomized(.cross)),
            ExampleItem(name: "leftDiagonal", type: .splitCustomized(.leftDiagonal)),
            ExampleItem(name: "rightDiagonal", type: .splitCustomized(.rightDiagonal)),
            ExampleItem(name: "crossDiagonal", type: .splitCustomized(.crossDiagonal)),
        ]),
        Examples(title: "Swing", list: [
            ExampleItem(name: "default, left", type: .swing),
            ExampleItem(name: "right", type: .swingCustomized(.right)),
            ExampleItem(name: "top", type: .swingCustomized(.top)),
            ExampleItem(name: "bottom", type: .swingCustomized(.bottom)),
        ]),
        Examples(title: "TiledFlip", list: [
            ExampleItem(name: "default, flipFromRight, row is 10 and column is 5", type: .tiledFlip),
            ExampleItem(name: "flipFromLeft, row is 10 and column is 10", type: .tiledFlipCustomized(.flipFromLeft, tiledRow: 10, tiledColumn: 10)),
            ExampleItem(name: "flipFromTop, row is 15 and column is 5", type: .tiledFlipCustomized(.flipFromTop, tiledRow: 15, tiledColumn: 5)),
            ExampleItem(name: "flipFromBottom, row is 15 and column is 10", type: .tiledFlipCustomized(.flipFromBottom, tiledRow: 15, tiledColumn: 10)),
            ExampleItem(name: "crossDissolve, row is 20 and column is 5", type: .tiledFlipCustomized(.crossDissolve, tiledRow: 20, tiledColumn: 5)),
            ExampleItem(name: "curlUp, row is 20 and column is 10", type: .tiledFlipCustomized(.curlUp, tiledRow: 20, tiledColumn: 10)),
            ExampleItem(name: "curlDown, row is 15 and column is 10", type: .tiledFlipCustomized(.curlDown, tiledRow: 15, tiledColumn: 10)),
        ])
    ]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 60)
        
        let collectionView : UICollectionView = UICollectionView(frame: CGRect(x:0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(HeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        view.addSubview(collectionView)
    }

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList[section].list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        
        cell?.imgView.image = UIImage(named: imgList.randomElement() ?? "")
        cell?.infoLabel.text = dataList[indexPath.section].list[indexPath.item].name
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeadView
            
            header.infoLabel.text = dataList[indexPath.section].title
            
            return header
        } else {
            let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            footer.backgroundColor = .clear
            
            return footer
        }
    }
 
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        
        let type = dataList[indexPath.section].list[indexPath.item].type
        
        let vc = StackViewController()
        vc.image = cell.imgView.image ?? UIImage()
        self.navigationController?.push(vc, type: type, duration: 1.0)
        
        // another way
//        self.navigationController?.push(vc, transition: JWStackTransition(type: type, duration: 1.0))
    }

}

