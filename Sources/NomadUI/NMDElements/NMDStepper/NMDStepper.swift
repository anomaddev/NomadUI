//
//  NMDStepper.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDStepperAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .value:        return "value"
        case .minimumValue: return "minimumValue"
        case .maximumValue: return "maximumValue"
        case .stepValue:    return "stepValue"
        case .isContinuous: return "isContinuous"
        case .autorepeat:   return "autorepeat"
        case .wraps:        return "wraps"
        }
    }
    
    case value(Double)
    case minimumValue(Double)
    case maximumValue(Double)
    case stepValue(Double)
    case isContinuous(Bool)
    case autorepeat(Bool)
    case wraps(Bool)
}

open class NMDStepper: UIStepper, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .stepperAttributes([
            .minimumValue(0),
            .maximumValue(100),
            .stepValue(1)
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
        if let attribute = attribute as? NMDStepperAttribute {
            setStepperAttribute(attribute)
        }
    }
    
    public func setStepperAttribute(_ attribute: NMDStepperAttribute) {
        switch attribute {
        case .value(let value):
            self.value = value
        case .minimumValue(let value):
            minimumValue = value
        case .maximumValue(let value):
            maximumValue = value
        case .stepValue(let value):
            stepValue = value
        case .isContinuous(let continuous):
            isContinuous = continuous
        case .autorepeat(let autorepeat):
            self.autorepeat = autorepeat
        case .wraps(let wraps):
            self.wraps = wraps
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
