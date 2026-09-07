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
        case .direction:            return "direction"
        case .distribution:         return "distribution"
        case .alignment:            return "alignment"
        case .spacing:              return "spacing"
        case .arrangedSubviews:     return "arrangedSubviews"
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
    
    /// Children added as arranged subviews when the stack is set up.
    case arrangedSubviews([UIView])
    
    /// Compare by attribute key, matching `NMDAttribute` default equality.
    /// Required because `arrangedSubviews` carries `[UIView]`, which blocks
    /// automatic `Equatable` synthesis.
    public static func == (lhs: NMDStackAttribute, rhs: NMDStackAttribute) -> Bool {
        lhs.value == rhs.value
    }
    
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
    
    open var defaultAttributes: [NMDAttributeCategory] = [
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
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDStackAttribute {
            setStackAttribute(attribute)
        }
    }
    
    public func setStackAttribute(_ attribute: NMDStackAttribute) {
        switch attribute {
            
        case .direction(let dir):
            axis = dir
            
        case .distribution(let distro):
            distribution = distro
            
        case .alignment(let align):
            alignment = align
            
        case .spacing(let space):
            spacing = space
            
        case .arrangedSubviews(let views):
            views.forEach { addArrangedSubview($0) }
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
