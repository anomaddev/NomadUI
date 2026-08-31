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
        case .isEnabled:        return "isEnabled"
        case .isSelected:       return "isSelected"
        case .disabledTitle:    return "disabledTitle"
        case .highlightedTitle: return "highlightedTitle"
        case .disabledIcon:     return "disabledIcon"
        case .highlightedIcon:  return "highlightedIcon"
        }
    }
    
    /// Canonical title for `.normal`. `NMDLabelAttribute.text` is a documented alias.
    case title(String)
    case icon(UIImage?)
    case iconInsets(UIEdgeInsets)
    case iconTintColor(UIColor)
    case isEnabled(Bool)
    case isSelected(Bool)
    case disabledTitle(String)
    case highlightedTitle(String)
    case disabledIcon(UIImage?)
    case highlightedIcon(UIImage?)
    
}

open class NMDButton: UIButton, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = []
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDButtonAttribute {
            setButtonAttribute(attribute)
        }
        if let attribute = attribute as? NMDLabelAttribute {
            setTextAttribute(attribute)
        }
    }
    
    /// Applies label attributes as title styling. `.text` is an alias for `.title`.
    public func setTextAttribute(_ attribute: NMDLabelAttribute) {
        switch attribute {
            
        case .text(let text):
            setTitle(text, for: .normal)
            
        case .textColor(let color):
            setTitleColor(color, for: .normal)
            
        case .font(let weight, let size):
            titleLabel?.font = weight.getFont(size: size)
            
        case .style(let style, let alternative):
            titleLabel?.font = style.uiFont(alternative: alternative)
            
        case .autoAdjustFont(let adjust):
            titleLabel?.adjustsFontSizeToFitWidth = adjust
            titleLabel?.minimumScaleFactor = 0.75
            
        case .minimumScaleFactor(let scale):
            titleLabel?.minimumScaleFactor = scale
            
        default: break
        }
    }
    
    public func setButtonAttribute(_ attribute: NMDButtonAttribute) {
        switch attribute {
            
        case .title(let title):
            setTitle(title, for: .normal)
            
        case .icon(let image):
            setImage(image, for: .normal)
            
        case .iconInsets(let insets):
            imageEdgeInsets = insets
            
        case .iconTintColor(let color):
            tintColor = color
            
        case .isEnabled(let enabled):
            isEnabled = enabled
            
        case .isSelected(let selected):
            isSelected = selected
            
        case .disabledTitle(let title):
            setTitle(title, for: .disabled)
            
        case .highlightedTitle(let title):
            setTitle(title, for: .highlighted)
            
        case .disabledIcon(let image):
            setImage(image, for: .disabled)
            
        case .highlightedIcon(let image):
            setImage(image, for: .highlighted)
            
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
