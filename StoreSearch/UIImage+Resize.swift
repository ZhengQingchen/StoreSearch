//
//  UIImage+Resize.swift
//  StoreSearch
//
//  Created by mac on 15/1/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resizedImageWithBounds(bounds:CGSize) -> UIImage{
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        let ratio = min(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        drawInRect(CGRect(origin: CGPointZero, size: newSize))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}