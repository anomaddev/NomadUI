//
//  NavigationController.swift
//
//
//  Created by Justin Ackermann on 5/9/24.
//

import UIKit

open class NavigationController: UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
    
    public func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
