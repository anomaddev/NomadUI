//
//  UITheme.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit

public class UITheme: NSObject {
    
    public static var main: UITheme = UITheme()
    
    public var light:   UIPalette = .defaultLight
    public var dark:    UIPalette = .defaultDark
    
    private override init() {
        super.init()
    }
    
    public func setTheme(basic theme: UIPalette) {
        self.light = theme
    }
    
    public func active() -> UIPalette {
        if #available(iOS 13.0, *) {
            return UITraitCollection.current.userInterfaceStyle == .dark ? dark : light
        } else {
            return light
        }
    }
}
