//
//  NomadUI+UIButton.swift
//
//
//  Created by Justin Ackermann on 5/11/24.
//

import UIKit

@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    fileprivate static func Login() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.background.cornerRadius = 5
        
        config.titleAlignment = .leading
        config.preferredSymbolConfigurationForImage = .init(pointSize: 20)
        config.imagePadding = 20
        config.imagePlacement = .trailing
        config.buttonSize = .medium
        
        return config
    }
    
    public static let FacebookLogin: UIButton.Configuration = {
        var container: AttributeContainer = .BaseButtonConfig
        
        var config: UIButton.Configuration = .Login()
        config.background.backgroundColor = .FacebookBlue
        config.image = UIImage(resource: .facebookSm)
        config.attributedTitle = AttributedString(
            "Login with Facebook",
            attributes: container
        )
        
        return config
    }()
    
    public static let AppleLogin: UIButton.Configuration = {
        var container: AttributeContainer = .BaseButtonConfig
        
        var config: UIButton.Configuration = .Login()
        config.background.backgroundColor = .black
        config.image = UIImage(resource: .appleSm)
        config.attributedTitle = AttributedString(
            "Login with Apple",
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
        container.font = Font.Regular.getFont(size: 17)
        
        return container
    }()
}
