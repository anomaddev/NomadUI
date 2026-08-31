//
//  NMDSegmentedControl.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDSegmentedControlAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .items:            return "items"
        case .selectedIndex:    return "selectedIndex"
        case .isMomentary:      return "isMomentary"
        case .selectedTint:     return "selectedTint"
        }
    }
    
    case items([String])
    case selectedIndex(Int)
    case isMomentary(Bool)
    case selectedTint(UIColor)
}

open class NMDSegmentedControl: UISegmentedControl, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = []
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(items: [] as [Any])
        setup(attributes)
    }
    
    public init(items: [String], selectedIndex: Int = 0) {
        super.init(items: items)
        setup([
            .segmentedAttributes([
                .selectedIndex(selectedIndex)
            ])
        ])
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDSegmentedControlAttribute {
            setSegmentedAttribute(attribute)
        }
    }
    
    public func setSegmentedAttribute(_ attribute: NMDSegmentedControlAttribute) {
        switch attribute {
        case .items(let items):
            removeAllSegments()
            items.enumerated().forEach { index, title in
                insertSegment(withTitle: title, at: index, animated: false)
            }
        case .selectedIndex(let index):
            selectedSegmentIndex = index
        case .isMomentary(let momentary):
            isMomentary = momentary
        case .selectedTint(let color):
            selectedSegmentTintColor = color
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
