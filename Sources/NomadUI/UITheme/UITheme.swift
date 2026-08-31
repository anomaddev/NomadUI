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
    
    public var light:   UIPalette = .defaultLight
    public var dark:    UIPalette = .defaultDark
    
    public var containers: [String: DynamicContainer] = [:]
    
    public var appFont: FontFamily = .HelveticaNeue
    public var altFont: FontFamily  = .HelveticaNeue
    
    public var setting: Adaptive {
        get { Defaults[.theme] }
        set { Defaults[.theme] = newValue }
    }
    
    public var osStyle: UIUserInterfaceStyle {
        if #available(iOS 13.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle
        } else {
            return .light
        }
    }
    
    public func setTheme(palette: UIPalette) {
        switch palette.adaptive {
        case .light:    light = palette
        case .dark:     dark = palette
        default: break
        }
    }
    
    public func setUnified(palette: UIPalette) {
        light = palette
        dark = palette
    }
    
    public func active() -> UIPalette {
        let effective = NomadUI.main.overrideThemeStyle ?? setting
        
        switch effective {
        case .dark:
            return dark
        case .light, .unified:
            return light
        case .followOS:
            return osStyle == .dark ? dark : light
        }
    }
}
