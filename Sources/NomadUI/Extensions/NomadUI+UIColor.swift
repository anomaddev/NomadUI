//
//  NomadUI+UIColor.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit

extension UIColor {
    
    /// Returns the current palette primary color
    public static var primary: PrimaryColor {
        UITheme.main.active().primary
    }
    
    /// Returns the current palette secondary color
    public static var secondary: PrimaryColor {
        UITheme.main.active().secondary
    }
    
    /// Returns the current palette tertiary color
    public static var tertiary: PrimaryColor {
        UITheme.main.active().tertiary
    }
    
    /// Returns the current palette error color
    public static var error: PrimaryColor {
        UITheme.main.active().error
    }
    
    /// Returns the current palette background color
    public static var background: BackgroundColor {
        UITheme.main.active().background
    }
    
    /// Returns the current palette neutral color
    public static var neutral: NeutralColor {
        UITheme.main.active().neutral
    }
}
