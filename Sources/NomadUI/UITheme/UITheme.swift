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
    
    public var style: UIUserInterfaceStyle {
        if #available(iOS 13.0, *) {
            return UITraitCollection.current.userInterfaceStyle
        } else {
            return .light
        }
    }
    
    private override init() {
        super.init()
    }
    
    public func setTheme(palette: UIPalette) {
        switch palette.adaptive {
        case .light:    light = palette
        case .dark:     dark = palette
        }
    }
    
    public func active() -> UIPalette {
        if #available(iOS 13.0, *) {
            print(style.rawValue)
            return style == .dark ? dark : light
        } else {
            return light
        }
    }
}
