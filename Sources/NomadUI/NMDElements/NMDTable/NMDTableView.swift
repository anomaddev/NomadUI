//
//  NMDTableView.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDTableViewAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .separatorStyle:               return "separatorStyle"
        case .separatorColor:               return "separatorColor"
        case .rowHeight:                    return "rowHeight"
        case .estimatedRowHeight:           return "estimatedRowHeight"
        case .keyboardDismissMode:          return "keyboardDismissMode"
        case .isScrollEnabled:              return "isScrollEnabled"
        case .allowsSelection:              return "allowsSelection"
        case .allowsMultipleSelection:      return "allowsMultipleSelection"
        case .sectionHeaderHeight:          return "sectionHeaderHeight"
        case .sectionFooterHeight:          return "sectionFooterHeight"
        }
    }
    
    case separatorStyle(UITableViewCell.SeparatorStyle)
    case separatorColor(UIColor?)
    case rowHeight(CGFloat)
    case estimatedRowHeight(CGFloat)
    case keyboardDismissMode(UIScrollView.KeyboardDismissMode)
    case isScrollEnabled(Bool)
    case allowsSelection(Bool)
    case allowsMultipleSelection(Bool)
    case sectionHeaderHeight(CGFloat)
    case sectionFooterHeight(CGFloat)
}

open class NMDTableView: UITableView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.background.color)
        ]),
        .tableAttributes([
            .separatorStyle(.singleLine),
            .rowHeight(UITableView.automaticDimension),
            .estimatedRowHeight(44),
            .keyboardDismissMode(.interactive)
        ])
    ]
    
    public init(
        style: UITableView.Style = .plain,
        _ attributes: [NMDAttributeCategory] = []
    ) {
        super.init(frame: .zero, style: style)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDTableViewAttribute {
            setTableAttribute(attribute)
        }
        if let attribute = attribute as? NMDScrollViewAttribute {
            setSharedScrollAttribute(attribute)
        }
    }
    
    public func setTableAttribute(_ attribute: NMDTableViewAttribute) {
        switch attribute {
        case .separatorStyle(let style):
            separatorStyle = style
        case .separatorColor(let color):
            separatorColor = color
        case .rowHeight(let height):
            rowHeight = height
        case .estimatedRowHeight(let height):
            estimatedRowHeight = height
        case .keyboardDismissMode(let mode):
            keyboardDismissMode = mode
        case .isScrollEnabled(let enabled):
            isScrollEnabled = enabled
        case .allowsSelection(let allows):
            allowsSelection = allows
        case .allowsMultipleSelection(let allows):
            allowsMultipleSelection = allows
        case .sectionHeaderHeight(let height):
            sectionHeaderHeight = height
        case .sectionFooterHeight(let height):
            sectionFooterHeight = height
        }
    }
    
    private func setSharedScrollAttribute(_ attribute: NMDScrollViewAttribute) {
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
