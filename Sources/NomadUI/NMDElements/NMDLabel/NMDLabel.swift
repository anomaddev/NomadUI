//
//  NMDLabel.swift
//
//
//  Created by Justin Ackermann on 3/29/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

// Utilities
import Cartography

public enum NMDLabelAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .text:         return "text"
        case .textColor:    return "textColor"
        case .textAlignment: return "textAlignment"
        case .font:         return "font"
        case .altFont:      return "altFont"
        }
    }
    
    case text(String)
    case textColor(UIColor)
    case textAlignment(NSTextAlignment)
    case font(weight: Font, size: CGFloat)
    case altFont(weight: Font, size: CGFloat)
    
}

public class NMDLabel: UILabel, NMDElement {
    
    var defaultAttributes: [NMDAttributeCategory] = [
        .labelAttributes([
            .textColor(.background.onColor)
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
            
            if let attribute = $0 as? NMDLabelAttribute
            { setLabelAttribute(attribute) }
        }
    }
    
    public func setLabelAttribute(_ attribute: NMDLabelAttribute) {
        switch attribute {
            
            // Label
        case .text(let text):
            self.text = text
            
        case .textColor(let color):
            textColor = color
            
        case .textAlignment(let alignment):
            textAlignment = alignment
            
        case .font(let weight, let size):
            font = weight.getFont(size: size)
            
        case .altFont(let weight, let size):
            font = weight.getFont(size: size, alternative: true)
        }
    }
    
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
