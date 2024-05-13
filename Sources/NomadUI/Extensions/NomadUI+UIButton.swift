//
//  NomadUI+UIButton.swift
//
//
//  Created by Justin Ackermann on 5/11/24.
//

import UIKit

@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    fileprivate static var BaseButtonConfig: AttributeContainer = {
        var container = AttributeContainer()
        container.foregroundColor = .white
        container.font = Font.Regular.getFont(size: 16)
        
        return container
    }()
    
    public static let AppleLogin: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .FacebookBlue
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString(
            "Login with Facebook",
            attributes: UIButton.Configuration.BaseButtonConfig
        )
        
        return config
    }()
    
}
