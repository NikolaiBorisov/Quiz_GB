//
//  UIButton+Animation.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.90
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
    
}
