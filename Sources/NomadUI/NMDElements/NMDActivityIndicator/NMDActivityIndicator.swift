//
//  NMDActivityIndicator.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDActivityIndicatorAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .style:        return "style"
        case .color:        return "color"
        case .isAnimating:  return "isAnimating"
        case .hidesWhenStopped: return "hidesWhenStopped"
        }
    }
    
    case style(UIActivityIndicatorView.Style)
    case color(UIColor)
    case isAnimating(Bool)
    case hidesWhenStopped(Bool)
}

open class NMDActivityIndicator: UIActivityIndicatorView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .activityAttributes([
            .style(.medium),
            .color(.primary.color),
            .hidesWhenStopped(true)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(style: .medium)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDActivityIndicatorAttribute {
            setActivityAttribute(attribute)
        }
    }
    
    public func setActivityAttribute(_ attribute: NMDActivityIndicatorAttribute) {
        switch attribute {
        case .style(let style):
            self.style = style
        case .color(let color):
            self.color = color
        case .isAnimating(let animating):
            if animating { startAnimating() }
            else { stopAnimating() }
        case .hidesWhenStopped(let hides):
            hidesWhenStopped = hides
        }
    }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}
