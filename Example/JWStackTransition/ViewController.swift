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
        .clockWise(duration: 4),
        .antiClockWise(duration: 4),
        .imageRepeating(percent: 0.1, time: 0.2),
        .multiFlip(distance: 0.05, time: 0.2),
        .blank,
        .circle,
        .crossFade,
        .rectangler,
        .multiCircle,
        .flip,
        .tiledFlip(duration: 1.0),
        .angleLine(corner: .topLeft),
        .straightLine(rectEdge: .left),
        .collidingDiamonds(duration: 1.0, isVertical: true),
        .shrinkingGrowingDiamonds(duration: 1.0),
        .splitFromCenter,
        .swingIn(duration: 1.0, isLeft: false)
    ]
    
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
//        self.navigationController?.push(vc, withType: .multiFlip, withDuration: 0.33)
        
        self.navigationController?.push(vc, with: JWStackTransition(type: dataList[indexPath.item]))
    }

}

