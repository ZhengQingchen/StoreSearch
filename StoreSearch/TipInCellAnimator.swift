//
//  TipInCellAnimator.swift
//  CardTilt
//
//  Created by mac on 15/1/26.
//  Copyright (c) 2015年 RayWenderlich.com. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

let TipInCellAnimatorStartTransform:CATransform3D = {
    let rotationDegree:CGFloat = -15.0
    let rotationRadians:CGFloat = rotationDegree * (CGFloat(M_PI) / 180.0)
    let offset = CGPointMake(-20, -20)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DRotate(CATransform3DIdentity, rotationRadians, 0.0, 0.0, 1.0)
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
    
    return startTransform
}()

class TipInCellAnimator {
    class func animate(cell: UITableViewCell) {
        let view = cell
        view.layer.opacity = 0
        view.transform = CGAffineTransformMakeScale(1.2, 1.2)
        
        UIView.animateWithDuration(0.5) {
        view.layer.opacity = 1
        view.transform = CGAffineTransformMakeScale(1, 1)

        }
    }
    
    class func newAnimate(cell: UITableViewCell) {
        let view = cell.contentView
        view.layer.transform = TipInCellAnimatorStartTransform
        view.layer.opacity = 0.8
        
        UIView.animateWithDuration(0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
    
}