//
//  NMDHeaderFooter.swift
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

open class NMDHeaderFooter: UITableViewHeaderFooterView {
    
    public static func getId() -> String { id }
    open class var id: String { return "headerFooter" }
    
    public lazy var row: NMDRow = NMDRow([
        .stackAttributes([
            .distribution(.fill),
            .alignment(.center),
            .spacing(10)
        ])
    ])
    
    public var titleView: NMDLabel!
    public lazy var subtitleView: NMDLabel = NMDLabel(style: .H3, align: .right)
    
    public static func register(on table: UITableView)
    { table.register(self, forHeaderFooterViewReuseIdentifier: id)}
    
    public static func dequeue(on table: UITableView) -> Self?
    { return table.dequeueReusableHeaderFooterView(withIdentifier: id) as? Self }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        row.arrangedSubviews.forEach {
            row.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    open func basicTitle(_ text: String) {
        titleView = NMDLabel(text, style: .B(size: 19), height: 25)
        row.addArrangedSubview(titleView)
        row.fitTo(self, padding: .surrounding(vertical: 5, horizontal: 15))
        
        layoutIfNeeded()
    }
    
    open func defaultLayout(title: String? = nil,
                            subtitle: String? = nil,
                            insets: UIEdgeInsets? = .surrounding(vertical: 5, horizontal: 15),
                            style header: NMDLabelStyle! = .H3) {
        titleView = NMDLabel(title, style: header, height: 20)
        subtitleView.text = subtitle
        
        row.addArrangedSubview(titleView)
        row.addArrangedSubview(subtitleView)
        row.fitTo(self, padding: insets)
        
        layoutIfNeeded()
    }
    
    open func centeredLayout(
        title: String? = nil,
        color: UIColor! = .background.onColor,
        style header: NMDLabelStyle! = .M(size: 12)
    ) {
        titleView = NMDLabel(title, style: header, color: color, align: .center, height: 17)
        row.addArrangedSubview(titleView)
        row.fitTo(self, padding: .surrounding(vertical: 5, horizontal: 15))
        
        layoutIfNeeded()
    }
}
