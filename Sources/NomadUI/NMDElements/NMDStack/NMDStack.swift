//
//  NMDStack.swift
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

public enum NMDStackAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .direction:    return "direction"
        case .distribution: return "distribution"
        case .alignment:    return "alignment"
        case .spacing:      return "spacing"
        }
    }
    
    /// axis of the stackview, default is `.vertical`
    case direction(NSLayoutConstraint.Axis)
    
    /// distribution of the stackview, default is `.fill`
    case distribution(UIStackView.Distribution)
    
    /// alignment of the stackview, default is `.fill`
    case alignment(UIStackView.Alignment)
    
    /// spacing between the stackview's arrangedSubviews, default is `10`
    case spacing(CGFloat)
    
}

open class NMDRow: NMDStack {
    
    override public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(attributes + [.stackAttributes([.direction(.horizontal)])])
    }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}

open class NMDColumn: NMDStack {
    
    override public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(attributes + [.stackAttributes([.direction(.vertical)])])
    }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}

open class NMDStack: UIStackView, NMDElement {
    
    var defaultAttributes: [NMDAttributeCategory] = [
        .stackAttributes([
            .direction(.vertical),
            .distribution(.fill),
            .alignment(.fill),
            .spacing(10)
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
            
            if let attribute = $0 as? NMDStackAttribute
            { setStackAttribute(attribute) }
        }
    }
    
    public func setStackAttribute(_ attribute: NMDStackAttribute) {
        switch attribute {
            
            // Stack
        case .direction(let dir):
            axis = dir
            
        case .distribution(let distro):
            distribution = distro
            
        case .alignment(let align):
            alignment = align
            
        case .spacing(let space):
            spacing = space
        }
    }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}

extension UIStackView {
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
