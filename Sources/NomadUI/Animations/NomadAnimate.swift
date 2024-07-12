//
//  NomadAnimate.swift
//
//
//  Created by Justin Ackermann on 7/4/24.
//

import UIKit

public struct NomadAnimateParams {
    
    public var duration: TimeInterval = 0.3
    public var delay: TimeInterval = 0
    public var curve: UIView.AnimationOptions = .curveEaseInOut
    
    public init(
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0,
        curve: UIView.AnimationOptions = .curveEaseInOut) {
            
        self.duration = duration
        self.delay = delay
        self.curve = curve
    }
    
    public func chain(
        _ animations: @escaping () -> Void,
        completion: ((NomadAnimateParams) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: curve,
            animations: animations
        ) { _ in completion?(self) }
    }
}

extension UIView {
    
    public static func animate(
        _ animate: NomadAnimateParams,
        _ animations: @escaping () -> Void,
        completion: ((NomadAnimateParams) -> Void)? = nil) {
            
        UIView.animate(
            withDuration: animate.duration,
            delay: animate.delay,
            options: animate.curve,
            animations: animations
        ) { _ in completion?(animate) }
    }
}
