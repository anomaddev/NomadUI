//
//  NMDScrollView.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDScrollViewAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .isPagingEnabled:                  return "isPagingEnabled"
        case .bounces:                          return "bounces"
        case .alwaysBounceVertical:             return "alwaysBounceVertical"
        case .alwaysBounceHorizontal:           return "alwaysBounceHorizontal"
        case .showsVerticalScrollIndicator:     return "showsVerticalScrollIndicator"
        case .showsHorizontalScrollIndicator:   return "showsHorizontalScrollIndicator"
        case .keyboardDismissMode:              return "keyboardDismissMode"
        case .contentInset:                     return "contentInset"
        case .isScrollEnabled:                  return "isScrollEnabled"
        case .contentInsetAdjustmentBehavior:   return "contentInsetAdjustmentBehavior"
        }
    }
    
    case isPagingEnabled(Bool)
    case bounces(Bool)
    case alwaysBounceVertical(Bool)
    case alwaysBounceHorizontal(Bool)
    case showsVerticalScrollIndicator(Bool)
    case showsHorizontalScrollIndicator(Bool)
    case keyboardDismissMode(UIScrollView.KeyboardDismissMode)
    case contentInset(UIEdgeInsets)
    case isScrollEnabled(Bool)
    case contentInsetAdjustmentBehavior(UIScrollView.ContentInsetAdjustmentBehavior)
}

open class NMDScrollView: UIScrollView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .scrollAttributes([
            .showsVerticalScrollIndicator(true),
            .showsHorizontalScrollIndicator(false),
            .keyboardDismissMode(.interactive)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: attributes.viewFrame ?? .zero)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDScrollViewAttribute {
            setScrollAttribute(attribute)
        }
    }
    
    public func setScrollAttribute(_ attribute: NMDScrollViewAttribute) {
        switch attribute {
        case .isPagingEnabled(let paging):
            isPagingEnabled = paging
        case .bounces(let bounces):
            self.bounces = bounces
        case .alwaysBounceVertical(let bounce):
            alwaysBounceVertical = bounce
        case .alwaysBounceHorizontal(let bounce):
            alwaysBounceHorizontal = bounce
        case .showsVerticalScrollIndicator(let shows):
            showsVerticalScrollIndicator = shows
        case .showsHorizontalScrollIndicator(let shows):
            showsHorizontalScrollIndicator = shows
        case .keyboardDismissMode(let mode):
            keyboardDismissMode = mode
        case .contentInset(let inset):
            contentInset = inset
        case .isScrollEnabled(let enabled):
            isScrollEnabled = enabled
        case .contentInsetAdjustmentBehavior(let behavior):
            contentInsetAdjustmentBehavior = behavior
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
