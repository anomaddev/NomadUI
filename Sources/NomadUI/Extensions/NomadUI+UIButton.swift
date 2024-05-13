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
        var container = AttributeContainer()
        container.foregroundColor = .primary.onColor
        container.font = Font.Regular.getFont(size: 16)
        
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .FacebookBlue
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString(
            "Login with Facebook",
            attributes: container
        )
        
        return config
    }()
    
}
