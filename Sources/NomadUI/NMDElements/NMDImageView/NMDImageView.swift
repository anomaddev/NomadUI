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
        case .image: return "image"
        }
    }
    
    case image(UIImage)
    
}

public class NMDImageView: UIImageView, NMDElement {
    
    var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .contentMode(.scaleAspectFit)
        ])
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
            
            if let attribute = $0 as? NMDImageViewAttribute
            { setImageViewAttribute(attribute) }
        }
    }
    
    public func setImageViewAttribute(_ attribute: NMDImageViewAttribute) {
        switch attribute {
            
            // ImageView
        case .image(let img):
            image = img
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}



