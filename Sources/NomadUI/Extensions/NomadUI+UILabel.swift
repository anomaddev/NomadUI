//
//  NomadUI+UILabel.swift
//
//
//  Created by Justin Ackermann on 5/27/24.
//

import UIKit

extension UILabel {
    
    /// Change the text of a label with an animation
    ///
    /// - parameter text: A `String` value to represent the new text to change to
    ///
    public func changeTo(_ text: String, duration: TimeInterval! = 0.5) {
        UIView.animate(withDuration: duration / 2, animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.text = text
            UIView.animate(withDuration: duration / 2, animations: {
                self.alpha = 1
                self.layoutIfNeeded()
            })
        }
    }
}
