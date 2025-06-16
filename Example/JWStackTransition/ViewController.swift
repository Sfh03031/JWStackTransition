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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let imgList = ["galleryImage01", "galleryImage02", "galleryImage03", "galleryImage04", "galleryImage05", "galleryImage06", "galleryImage07", "galleryImage08", "lightning1", "lightning2", "moon1", "moon2", "snow1", "snow2", "sun1", "sun2", "tornado1", "tornado2"]
    
    let dataList = [
        Examples(title: "Door", list: [
            ExampleItem(name: "default, door open", type: .door),
            ExampleItem(name: "door colse", type: .doorCustomized(.close)),
        ]),
        Examples(title: "Explode", list: [
            ExampleItem(name: "default, explode piece width is 30.0", type: .explode),
            ExampleItem(name: "random in [20.0, 200.0]", type: .explodeCustomized(CGFloat.random(in: 20.0...200.0))),
        ]),
        Examples(title: "Flip", list: [
            ExampleItem(name: "default, fromLeftToRight", type: .Flip),
            ExampleItem(name: "fromRightToLeft", type: .FlipCustomized(.fromRightToLeft))
        ]),
        Examples(title: "Fold", list: [
            ExampleItem(name: "default, fromLeftToRight and fold number is 2", type: .fold),
            ExampleItem(name: "fromLeftToRight and fold number is 4", type: .foldCustomized(.fromLeftToRight, foldNum: 4)),
            ExampleItem(name: "fromRightToLeft and fold number is 2", type: .foldCustomized(.fromRightToLeft, foldNum: 2)),
            ExampleItem(name: "fromRightToLeft and fold number is 4", type: .foldCustomized(.fromRightToLeft, foldNum: 4))
        ]),
        Examples(title: "AntiClockWise", list: [
            ExampleItem(name: "default, start angle is 1.5", type: .antiClockWise),
            ExampleItem(name: "start angle is 0.0", type: .antiClockWiseCustomized(0.0)),
            ExampleItem(name: "start angle is 0.5", type: .antiClockWiseCustomized(0.5)),
            ExampleItem(name: "start angle is 1.0", type: .antiClockWiseCustomized(1.0)),
            ExampleItem(name: "start angle is 2.0", type: .antiClockWiseCustomized(2.0))
        ]),
        Examples(title: "Barrier", list: [
            ExampleItem(name: "default, toTop and width is 20", type: .barrier),
            ExampleItem(name: "toLeft and width is 20", type: .barrierCustomized(.toLeft, width: 5)),
            ExampleItem(name: "toRight and width is 20", type: .barrierCustomized(.toRight, width: 10.0)),
            ExampleItem(name: "toBottom and width is 20", type: .barrierCustomized(.toBottom, width: 15.0)),
            ExampleItem(name: "toVerticalCenter and width is 20", type: .barrierCustomized(.toVerticalCenter, width: 20.0)),
            ExampleItem(name: "toHorizontalCenter and width is 20", type: .barrierCustomized(.toHorizontalCenter, width: 25.0)),
        ]),
        Examples(title: "Circle", list: [
            ExampleItem(name: "default", type: .circle)
        ]),
        Examples(title: "ClockWise", list: [
            ExampleItem(name: "default, start angle is 0.5", type: .clockWise),
            ExampleItem(name: "start angle is 0.0", type: .clockWiseCustomized(0.0)),
            ExampleItem(name: "start angle is 1.0", type: .clockWiseCustomized(1.0)),
            ExampleItem(name: "start angle is 1.5", type: .clockWiseCustomized(1.5)),
            ExampleItem(name: "start angle is 2.0", type: .clockWiseCustomized(2.0))
        ]),
        Examples(title: "Fence", list: [
            ExampleItem(name: "default, verticalLeft and width is 20", type: .fence),
            ExampleItem(name: "verticalRight and width is 5", type: .fenceCustomized(.verticalRight, width: 5.0)),
            ExampleItem(name: "verticalCross and width is 10", type: .fenceCustomized(.verticalCross, width: 10.0)),
            ExampleItem(name: "horizontalTop and width is 15", type: .fenceCustomized(.horizontalTop, width: 15.0)),
            ExampleItem(name: "horizontalBottom and width is 20", type: .fenceCustomized(.horizontalBottom, width: 20.0)),
            ExampleItem(name: "horizontalCross and width is 25", type: .fenceCustomized(.horizontalCross, width: 25.0)),
        ]),
        
        Examples(title: "MultiCircle", list: [
            ExampleItem(name: "default, diameter is 20", type: .multiCircle),
            ExampleItem(name: "diameter is 30", type: .multiCircleCustomized(30)),
            ExampleItem(name: "diameter is 40", type: .multiCircleCustomized(40)),
            ExampleItem(name: "diameter is 50", type: .multiCircleCustomized(50)),
            ExampleItem(name: "diameter is 60", type: .multiCircleCustomized(60)),
            ExampleItem(name: "diameter is 80", type: .multiCircleCustomized(80)),
        ]),
        Examples(title: "Multinest", list: [
            ExampleItem(name: "default", type: .multinest)
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
            ExampleItem(name: "default", type: .rotate),
        ]),
        Examples(title: "Sector", list: [
            ExampleItem(name: "default, left", type: .sector),
            ExampleItem(name: "right", type: .sectorCustomized(.right)),
            ExampleItem(name: "top", type: .sectorCustomized(.top)),
            ExampleItem(name: "bottom", type: .sectorCustomized(.bottom)),
        ]),
        Examples(title: "Slant", list: [
            ExampleItem(name: "default, topLeft", type: .slant),
            ExampleItem(name: "topRight", type: .slantCustomized(.topRight)),
            ExampleItem(name: "bottomLeft", type: .slantCustomized(.bottomLeft)),
            ExampleItem(name: "bottomRight", type: .slantCustomized(.bottomRight)),
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
        ]),
        Examples(title: "translate", list: [
            ExampleItem(name: "default, left", type: .translate),
            ExampleItem(name: "right", type: .translateCustomized(.right)),
            ExampleItem(name: "top", type: .translateCustomized(.top)),
            ExampleItem(name: "bottom", type: .translateCustomized(.bottom)),
        ]),
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

