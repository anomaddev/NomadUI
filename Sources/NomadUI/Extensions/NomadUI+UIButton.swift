//
//  NomadUI+UIButton.swift
//
//
//  Created by Justin Ackermann on 5/11/24.
//

import UIKit

@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    public static let AppleLogin: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .FacebookBlue
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString(
            "Login with Facebook",
            attributes: AttributeContainer([
                Font.Key: Font.Regular.getFont(size: 16),
                UIColor.Foreground: UIColor.primary.onColor
            ])
        )
        
        return config
    }()
    
}
