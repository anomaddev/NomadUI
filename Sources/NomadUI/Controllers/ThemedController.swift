//
//  ThemedController.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit

open class ThemedController: UIViewController {
    
    public var palatte: UIPalette = UITheme.main.active()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = palatte.background.color
        
    }
}
