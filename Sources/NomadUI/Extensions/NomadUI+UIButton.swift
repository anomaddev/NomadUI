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
        var container: AttributeContainer = .BaseButtonConfig
        
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .FacebookBlue
        config.background.cornerRadius = 5
        config.attributedTitle = AttributedString(
            "Login with Facebook",
            attributes: container
        )
        
        return config
    }()
    
}

@available(iOS 15, *)
extension AttributeContainer {
    fileprivate static var BaseButtonConfig: AttributeContainer = {
        var container = AttributeContainer()
        container.foregroundColor = .white
        container.font = Font.Regular.getFont(size: 16)
        
        return container
    }()
}
