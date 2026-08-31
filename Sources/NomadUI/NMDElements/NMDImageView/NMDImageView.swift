//
//  NMDImageView.swift
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

public enum NMDImageViewAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .image, .optionalImage:    return "image"
        case .highlightedImage:         return "highlightedImage"
        case .tint:                     return "tintColor"
        }
    }
    
    case image(UIImage)
    case optionalImage(UIImage?)
    case highlightedImage(UIImage?)
    case tint(UIColor)
    
}

open class NMDImageView: UIImageView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .contentMode(.scaleAspectFit)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDImageViewAttribute {
            setImageViewAttribute(attribute)
        }
    }
    
    public func setImageViewAttribute(_ attribute: NMDImageViewAttribute) {
        switch attribute {
            
        case .image(let img):
            image = img
            
        case .optionalImage(let img):
            image = img
            
        case .highlightedImage(let img):
            highlightedImage = img
            
        case .tint(let color):
            tintColor = color
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
