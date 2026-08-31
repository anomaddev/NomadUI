//
//  NMDCell.swift
//
//
//  Created by Justin Ackermann on 6/13/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

// Utilities
import Cartography
import SwipeCellKit

open class NMDCell: UITableViewCell, NMDElement {
    
    public static func getId() -> String { cellId }
    open class var cellId: String { return "cell" }
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.background.color)
        ])
    ]
    
    public static func register(on table: UITableView)
    { table.register(self, forCellReuseIdentifier: cellId)}
    
    public static func dequeue(on table: UITableView, for index: IndexPath? = nil) -> Self? {
        if let i = index { return table.dequeueReusableCell(withIdentifier: cellId, for: i) as? Self }
        else { return table.dequeueReusableCell(withIdentifier: cellId) as? Self }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup(defaultAttributes)
        layout()
    }
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(style: .default, reuseIdentifier: Self.cellId)
        setup(attributes)
        layout()
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
            if case .backgroundColor(let color) = attribute {
                contentView.backgroundColor = color
            }
        }
    }
    
    /// Hook for subclasses to compose content after attributes are applied.
    open func layout() {
        selectionStyle = .none
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class NMDCellSwipeable: SwipeTableViewCell, NMDElement {
    
    public static func getId() -> String { cellId }
    open class var cellId: String { return "swipecell" }
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.background.color)
        ])
    ]
    
    public static func register(on table: UITableView)
    { table.register(self, forCellReuseIdentifier: cellId)}
    
    public static func dequeue(on table: UITableView, for index: IndexPath? = nil) -> NMDCellSwipeable? {
        if let i = index { return table.dequeueReusableCell(withIdentifier: cellId, for: i) as? NMDCellSwipeable }
        else { return table.dequeueReusableCell(withIdentifier: cellId) as? NMDCellSwipeable }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup(defaultAttributes)
        layout()
    }
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(style: .default, reuseIdentifier: Self.cellId)
        setup(attributes)
        layout()
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
            if case .backgroundColor(let color) = attribute {
                contentView.backgroundColor = color
            }
        }
    }
    
    /// Hook for subclasses to compose content after attributes are applied.
    open func layout() {
        selectionStyle = .none
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
