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

open class NMDCell: UITableViewCell {
    public static func getId() -> String { cellId }
    open class var cellId: String { return "cell" }
    
    public static func register(on table: UITableView)
    { table.register(self, forCellReuseIdentifier: cellId)}
    
    public static func dequeue(on table: UITableView, for index: IndexPath? = nil) -> Self? {
        if let i = index { return table.dequeueReusableCell(withIdentifier: cellId, for: i) as? Self }
        else { return table.dequeueReusableCell(withIdentifier: cellId) as? Self }
    }
    
//    open func layout(with model: TableCellModel) {
//        selectionStyle = .none
//        backgroundColor = .background.color
//    }
}

open class NMDCellSwipeable: SwipeTableViewCell {
    public static func getId() -> String { cellId }
    open class var cellId: String { return "swipecell" }
    
    public static func register(on table: UITableView)
    { table.register(self, forCellReuseIdentifier: cellId)}
    
    public static func dequeue(on table: UITableView, for index: IndexPath? = nil) -> NMDCellSwipeable? {
        if let i = index { return table.dequeueReusableCell(withIdentifier: cellId, for: i) as? NMDCellSwipeable }
        else { return table.dequeueReusableCell(withIdentifier: cellId) as? NMDCellSwipeable }
    }
    
//    open func layout(with model: TableCellModel) {
//        selectionStyle = .none
//        backgroundColor = .background.color
//    }
}

