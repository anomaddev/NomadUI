//
//  NMDSwitch.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDSwitchAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .isOn:             return "isOn"
        case .onTintColor:      return "onTintColor"
        case .thumbTintColor:   return "thumbTintColor"
        }
    }
    
    case isOn(Bool)
    case onTintColor(UIColor)
    case thumbTintColor(UIColor)
}

open class NMDSwitch: UISwitch, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .switchAttributes([
            .onTintColor(.primary.color)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
    }
    
    public init(isOn: Bool) {
        super.init(frame: .zero)
        setup([.switchAttributes([.isOn(isOn)])])
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDSwitchAttribute {
            setSwitchAttribute(attribute)
        }
    }
    
    public func setSwitchAttribute(_ attribute: NMDSwitchAttribute) {
        switch attribute {
        case .isOn(let on):
            isOn = on
        case .onTintColor(let color):
            onTintColor = color
        case .thumbTintColor(let color):
            thumbTintColor = color
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
