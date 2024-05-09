//
//  BasicController.swift
//
//
//  Created by Justin Ackermann on 5/9/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

open class BasicController: UIViewController {
    
    public var palatte: UIPalette = UITheme.main.active()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = palatte.background.color
        
    }
    
    open func handle(_ error: Error) {
        error.explain()
    }
}
