//
//  NMDSlider.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDSliderAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .value:            return "value"
        case .minimumValue:     return "minimumValue"
        case .maximumValue:     return "maximumValue"
        case .minimumTrackTint: return "minimumTrackTint"
        case .maximumTrackTint: return "maximumTrackTint"
        case .thumbTint:        return "thumbTint"
        case .isContinuous:     return "isContinuous"
        }
    }
    
    case value(Float)
    case minimumValue(Float)
    case maximumValue(Float)
    case minimumTrackTint(UIColor)
    case maximumTrackTint(UIColor)
    case thumbTint(UIColor)
    case isContinuous(Bool)
}

open class NMDSlider: UISlider, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .sliderAttributes([
            .minimumValue(0),
            .maximumValue(1),
            .minimumTrackTint(.primary.color)
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
        if let attribute = attribute as? NMDSliderAttribute {
            setSliderAttribute(attribute)
        }
    }
    
    public func setSliderAttribute(_ attribute: NMDSliderAttribute) {
        switch attribute {
        case .value(let value):
            self.value = value
        case .minimumValue(let value):
            minimumValue = value
        case .maximumValue(let value):
            maximumValue = value
        case .minimumTrackTint(let color):
            minimumTrackTintColor = color
        case .maximumTrackTint(let color):
            maximumTrackTintColor = color
        case .thumbTint(let color):
            thumbTintColor = color
        case .isContinuous(let continuous):
            isContinuous = continuous
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
