//
//  PhotoCell.swift
//  JWStackTransition_Example
//
//  Created by sfh on 2025/6/13.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imgView)
        self.addSubview(infoLabel)
        imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray.withAlphaComponent(0.5)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
}
