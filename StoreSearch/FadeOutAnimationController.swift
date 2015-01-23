//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by mac on 15/1/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class FadeOutAnimationController: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval{
        return 0.4
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey){
            let duration = transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                fromView.alpha = 0
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }

}
