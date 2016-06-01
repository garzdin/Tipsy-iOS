//
//  ViewShake.swift
//  Tipsy
//
//  Created by Teodor on 01/06/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

extension CALayer {
    func shake(duration: NSTimeInterval = NSTimeInterval(0.5)) {
        
        let animationKey = "shake"
        removeAnimationForKey(animationKey)
        
        let kAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        kAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        kAnimation.duration = duration
        
        var needOffset = CGRectGetWidth(frame) * 0.15,
        values = [CGFloat]()
        
        let minOffset = needOffset * 0.1
        
        repeat {
            values.append(-needOffset)
            values.append(needOffset)
            needOffset *= 0.5
        } while needOffset > minOffset
        
        values.append(0)
        kAnimation.values = values
        addAnimation(kAnimation, forKey: animationKey)
    }
}