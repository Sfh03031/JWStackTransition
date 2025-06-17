//
//  StackViewController.swift
//  JWStackTransition_Example
//
//  Created by sfh on 2025/5/20.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import JWStackTransition

class StackViewController: UIViewController {
    
    var image: UIImage = UIImage() {
        didSet {
            self.imgView.image = image
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(imgView)
        imgView.frame = self.view.bounds
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        self.navigationController?.pop(JWStackTransitionType.allCases.randomElement())
    }

    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return view
    }()

}
