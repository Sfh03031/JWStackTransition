//
//  HeadView.swift
//  JWStackTransition_Example
//
//  Created by sfh on 2025/6/13.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class HeadView: UICollectionReusableView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
}
