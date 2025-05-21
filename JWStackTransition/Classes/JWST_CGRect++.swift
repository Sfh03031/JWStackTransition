//
//  JWST_CGRect++.swift
//  Pods
//
//  Created by sfh on 2025/5/21.
//

extension CGRect {
    
    func toIncrement(_ target: CGFloat) -> CGRect {
        return CGRect(x: self.origin.x + target,
                      y: self.origin.y + target,
                      width: self.size.width - target * 2,
                      height: self.size.height - target * 2)
    }
}
