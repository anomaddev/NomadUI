//
//  UITheme.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit
import Defaults

extension Defaults.Keys {
    
    public static let theme = Key<Adaptive>("theme", default: .followOS)
    
}


public class UITheme: NSObject {
    
    public static var main: UITheme = {
        let thm = UITheme()
        let active = Defaults[.theme]
        
        print("Active Theme: \(active.label)")
        thm.setting = active
        return thm
    }()
    
    public var light:   UIPalette = .defaultLight
    public var dark:    UIPalette = .defaultDark
    
    public var setting: Adaptive = .followOS {
        didSet { Defaults[.theme] = setting }
    }
    
    public var osStyle: UIUserInterfaceStyle {
        if #available(iOS 13.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle
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
        default: break
        }
    }
    
    public func active() -> UIPalette {
        if #available(iOS 13.0, *) {
            guard setting == .followOS
            else { return setting == .dark ? dark : light }
            
            return osStyle == .dark ? dark : light
        } else {
            return light
        }
    }
}
