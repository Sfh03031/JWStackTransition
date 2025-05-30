//
//  StackViewController.swift
//  JWStackTransition_Example
//
//  Created by sfh on 2025/5/20.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
//    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        print("viewWillAppear - hide navigationBar")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        print("viewDidAppear - show navigationBar")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
