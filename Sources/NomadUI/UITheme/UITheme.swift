//
//  UITheme.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit
import Defaults

import NomadUtilities

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
        if NomadUtilities.shared.environment == .development {
            if let override = NomadUI.main.overrideThemeStyle {
                guard setting == .followOS
                else { return setting == .dark ? dark : light }
                
                return osStyle == .dark ? dark : light
            }
        }
        
        if #available(iOS 13.0, *) {
            guard setting == .followOS
            else { return setting == .dark ? dark : light }
            
            return osStyle == .dark ? dark : light
        } else {
            return light
        }
    }
}
