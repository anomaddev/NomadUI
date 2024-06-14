//
//  NMDButton.swift
//
//
//  Created by Justin Ackermann on 5/9/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

// Utilities
import Cartography

public enum NMDButtonAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .title:            return "title"
        case .icon:             return "icon"
        case .iconInsets:       return "iconInsets"
        case .iconTintColor:    return "iconTintColor"
        }
    }
    
    case title(String)
    case icon(UIImage?)
    case iconInsets(UIEdgeInsets)
    case iconTintColor(UIColor)
    
}

public class NMDButton: UIButton, NMDElement {
    
    var defaultAttributes: [NMDAttributeCategory] = [
        
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
    }
    
    internal func setup(_ attributes: [NMDAttributeCategory]) {
        let given = attributes.reduce([]) { $0 + $1.attributes }
        let defaults = defaultAttributes
            .reduce([]) { $0 + $1.attributes }
            .filter { atrib -> Bool in !given.contains(where: { $0.value == atrib.value })}
        
        let all = given + defaults
        all.forEach {
            if let attribute = $0 as? NMDViewAttribute
            { setViewAttribute(attribute) }
            
            if let attribute = $0 as? NMDButtonAttribute
            { setButtonAttribute(attribute) }
            
            if let attribute = $0 as? NMDLabelAttribute
            { setTextAttribute(attribute) }
        }
    }
    
    public func setTextAttribute(_ attribute: NMDLabelAttribute) {
        switch attribute {
            
            // Label
        case .text(let text):
            setTitle(text, for: .normal)
            
        case .textColor(let color):
            setTitleColor(color, for: .normal)
            
        case .font(let weight, let size):
            titleLabel?.font = weight.getFont(size: size)
            
        default: break
        }
    }
    
    public func setButtonAttribute(_ attribute: NMDButtonAttribute) {
        switch attribute {
            
            // ImageView
        case .title(let title):
            setTitle(title, for: .normal)
            
        case .icon(let image):
            setImage(image, for: .normal)
            
        case .iconInsets(let insets):
            imageEdgeInsets = insets
            
        case .iconTintColor(let color):
            tintColor = color
            
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}




