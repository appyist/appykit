//
//  AppyAnimation.swift
//  clapper
//
//  Created by Emirhan Erdogan on 21/05/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import Foundation
import QuartzCore

open class AppyAnimation {
    
    public class func generateAnimation(of type: AnimationType, force: CGFloat = 0.95) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [0, -0.2*force, 0.2*force, 0]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.1 + Float(force / 3), 1.0, 1.0)
        animation.duration = CFTimeInterval(1.5)
        animation.isAdditive = true
        animation.beginTime = CACurrentMediaTime()
        
        return animation
    }
}

public extension AppyAnimation {
    
    enum AnimationType {
        case pop
    }
}
