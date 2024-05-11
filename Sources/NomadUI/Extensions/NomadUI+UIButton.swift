//
//  NomadUI+UIButton.swift
//
//
//  Created by Justin Ackermann on 5/11/24.
//

import UIKit

@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    static let AppleLogin: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.title = "Login with Apple"
        config.attributedTitle = AttributedString(
            "Login with Facebook",
            attributes: AttributeContainer([
                Font.Key: Font.Medium.getFont(size: 16),
                UIColor.Foreground: UIColor.primary.onColor
            ])
        )
        
        return config
    }()
    
}
