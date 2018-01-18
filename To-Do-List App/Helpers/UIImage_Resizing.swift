//
//  ImageResizer.swift
//  To-Do-List App
//
//  Created by David on 18/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
        
        let originalSize = self.size
        let widthRatio = targetSize.width / originalSize.width
        let heightRatio = targetSize.height / originalSize.height
        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: originalSize.width * ratio, height: originalSize.height * ratio)
        
        print(originalSize)
        print(newSize)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        let hasAlpha = false
        
        UIGraphicsBeginImageContextWithOptions(newSize, hasAlpha, UIScreen.main.scale)
        self.draw(in: rect)
        
       let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}
