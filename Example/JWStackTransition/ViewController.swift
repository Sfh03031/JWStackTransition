//
//  ViewController.swift
//  JWStackTransition
//
//  Created by Sfh03031 on 05/20/2025.
//  Copyright (c) 2025 Sfh03031. All rights reserved.
//

import UIKit
import JWStackTransition

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let dataList: [JWStackTransitionType] = [
        
        .barrier(.toTop, width: 20),
        .barrier(.toLeft, width: 20),
        .barrier(.toRight, width: 20),
        .barrier(.toBottom, width: 20),
        .barrier(.toHorizontalCenter, width: 20),
        .barrier(.toVerticalCenter, width: 20),
        
        .fence(.verticalCross, width: 20),
        .fence(.horizontalCross, width: 20),
        .fence(.verticalLeft, width: 40),
        .fence(.verticalRight, width: 40),
        .fence(.horizontalTop, width: 40),
        .fence(.horizontalBottom, width: 40),
        
        
        .split(.cross),
        .split(.diamondVertical),
        .split(.diamondHorizontal),
        .split(.horizontal),
        .split(.vertical),
        .split(.leftDiagonal),
        .split(.rightDiagonal),
        .split(.crossDiagonal),
        .multinest,
        
        .rectangler(.waveIn),
        .rectangler(.waveOut),
        .roll(.x),
        .roll(.y),
        .roll(.z),
        .rotate,
        .multiCircle(10),
        
        .tiledFlip,
        .tiledFlipCustomized(.crossDissolve, tiledRow: 2, tiledColumn: 1),
        .tiledFlipCustomized(.curlDown, tiledRow: 4, tiledColumn: 2),
        .tiledFlipCustomized(.curlUp, tiledRow: 6, tiledColumn: 3),
        .tiledFlipCustomized(.flipFromBottom, tiledRow: 8, tiledColumn: 4),
        .tiledFlipCustomized(.flipFromTop, tiledRow: 10, tiledColumn: 5),
        .tiledFlipCustomized(.flipFromLeft, tiledRow: 12, tiledColumn: 6),
        .tiledFlipCustomized(.flipFromRight, tiledRow: 14, tiledColumn: 7),
        .tiledFlipCustomized(.flipFromRight, tiledRow: 16, tiledColumn: 8),
        .tiledFlipCustomized(.flipFromRight, tiledRow: 18, tiledColumn: 9),
        .tiledFlipCustomized(.flipFromRight, tiledRow: 20, tiledColumn: 10),
        
        .swing(.left),
        .swing(.right),
        .swing(.top),
        .swing(.bottom),
        
        .sector(.left),
        .sector(.top),
        .sector(.right),
        .sector(.bottom),
        
//        .sectorLeft,
//        .sectorTop,
//        .sectorRight,
//        .sectorBottom,
        
        .official(.crossDissolve),
        .official(.flipFromTop),
        .official(.flipFromLeft),
        .official(.flipFromRight),
        .official(.flipFromBottom),
        .official(.curlUp),
        .official(.curlDown),
        
        
        
        .translate(.left),
        .translate(.right),
        .translate(.top),
        .translate(.bottom),
        
        .slant(.topLeft),
        .slant(.topRight),
        .slant(.bottomLeft),
        .slant(.bottomRight),
        
        .clockWise(0.5),
        .antiClockWise(1.5),
        
        .circle,
        
        .blank,
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cellWidth = view.bounds.width / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let collectionView : UICollectionView = UICollectionView(frame: CGRect(x:0, y: 100, width: view.bounds.size.width, height: view.bounds.size.height - 134), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.addSubview(collectionView)
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath as IndexPath) 
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
        
        return cell
    }
 
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        let vc = StackViewController()
        vc.view.backgroundColor = cell.backgroundColor
        self.navigationController?.push(vc, type: dataList[indexPath.item], duration: 1.0)
        
//        self.navigationController?.push(vc, transition: JWStackTransition(type: dataList[indexPath.item]))
    }

}

