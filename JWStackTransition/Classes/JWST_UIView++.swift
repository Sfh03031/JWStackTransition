//
//  JWST_UIView++.swift
//  Pods
//
//  Created by sfh on 2025/5/21.
//

extension UIView {
    
    func viewShot() -> UIImage? {
        guard self.bounds.width > 0 && self.bounds.height > 0 else { return nil }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}
