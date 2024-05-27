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
    
    public var palatte: UIPalette = NomadUI.main.theme.active()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = palatte.background.color
        
    }
    
    @objc open func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    open func handle(_ error: Error) {
        error.explain()
    }
}
