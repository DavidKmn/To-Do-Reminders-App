//
//  Drawer.swift
//  To-Do-List App
//
//  Created by David on 21/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let lightBlue = #colorLiteral(red: 0.007843137255, green: 0.7960784314, blue: 0.8235294118, alpha: 1)
    static let brightYellow = #colorLiteral(red: 0.9882352941, green: 0.7529411765, blue: 0.1647058824, alpha: 1)
}

class PlusButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.lightBlue.setFill()
        path.fill()
        
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth + Constants.halfPoingShift, y: halfHeight + Constants.halfPoingShift))
        
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth + Constants.halfPoingShift, y: halfHeight + Constants.halfPoingShift))
        
        
        plusPath.move(to: CGPoint(x: halfWidth + Constants.halfPoingShift, y: halfHeight - halfPlusWidth + Constants.halfPoingShift))
        
        plusPath.addLine(to: CGPoint(x: halfWidth + Constants.halfPoingShift, y: halfHeight + halfPlusWidth + Constants.halfPoingShift))
        
        UIColor.white.setStroke()
        
        plusPath.stroke()
    }
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3
        static let plusButtonScale: CGFloat = 0.6
        static let halfPoingShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
}

extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
