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
    
    /// make gradient
    /// - Parameters:
    ///   - colors: gradient colors
    ///   - locations: gradient locations
    ///   - start: gradient start point
    ///   - end: gradient end point
    func makeGradient(_ colors: [Any], locations: [NSNumber], start: CGPoint, end: CGPoint) {
        let gradient = CAGradientLayer()
        gradient.colors = colors
//        gradient.locations = locations
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 1)
    }
}
