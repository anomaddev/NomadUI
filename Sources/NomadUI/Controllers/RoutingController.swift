//
//  RoutingController.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit
import FAPanels

open class RoutingController: FAPanelController {
    
    public var palatte: UIPalette = UITheme.main.active()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = palatte.background.color
        
    }
}
