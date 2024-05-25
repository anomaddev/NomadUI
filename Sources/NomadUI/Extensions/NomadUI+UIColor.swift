//
//  NomadUI+UIColor.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit
import UIColorHexSwift

extension UIColor {
    
    static var Foreground: NSAttributedString.Key = .foregroundColor
    static var Background: NSAttributedString.Key = .backgroundColor
    
    static let FacebookBlue: UIColor = .init("#1877F2")
    
    /// Returns the current palette primary color
    public static var primary: PrimaryColor {
        UITheme.main.active().primary
    }
    
    /// Returns the primary palette color of the specified style
    ///
    /// - parameter style: The style to force the primary color to
    /// - returns: The primary color of the specified style
    public static func forcePrimary(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.primary
        case .dark:     return UITheme.main.dark.primary
        case .followOS: fatalError("Cannot force primary color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette secondary color
    public static var secondary: PrimaryColor {
        UITheme.main.active().secondary
    }
    
    /// Returns the secondary palette color of the specified style
    ///
    /// - parameter style: The style to force the secondary color to
    /// - returns: The secondary color of the specified style
    public static func forceSecondary(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.error
        case .dark:     return UITheme.main.dark.error
        case .followOS: fatalError("Cannot force secondary color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette tertiary color
    public static var tertiary: PrimaryColor {
        UITheme.main.active().tertiary
    }
    
    /// Returns the tertiary palette color of the specified style
    ///
    /// - parameter style: The style to force the tertiary color to
    /// - returns: The tertiary color of the specified style
    public static func forceTertiary(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.error
        case .dark:     return UITheme.main.dark.error
        case .followOS: fatalError("Cannot force tertiary color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette success color
    public static var success: PrimaryColor {
        UITheme.main.active().success
    }
    
    /// Returns the success palette color of the specified style
    ///
    /// - parameter style: The style to force the success color to
    /// - returns: The success color of the specified style
    public static func forceSuccess(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.success
        case .dark:     return UITheme.main.dark.success
        case .followOS: fatalError("Cannot force success color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette warning color
    public static var warning: PrimaryColor {
        UITheme.main.active().warning
    }
    
    /// Returns the warning palette color of the specified style
    ///
    /// - parameter style: The style to force the warning color to
    /// - returns: The warning color of the specified style
    public static func forceWarning(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.warning
        case .dark:     return UITheme.main.dark.warning
        case .followOS: fatalError("Cannot force warning color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette error color
    public static var error: PrimaryColor {
        UITheme.main.active().error
    }
    
    /// Returns the error palette color of the specified style
    ///
    /// - parameter style: The style to force the error color to
    /// - returns: The error color of the specified style
    public static func forceError(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.error
        case .dark:     return UITheme.main.dark.error
        case .followOS: fatalError("Cannot force error color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette background color
    public static var background: BackgroundColor {
        UITheme.main.active().background
    }
    
    /// Returns the background palette color of the specified style
    ///
    /// - parameter style: The style to force the background color to
    /// - returns: The background color of the specified style
    public static func forceBackground(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.error
        case .dark:     return UITheme.main.dark.error
        case .followOS: fatalError("Cannot force background color to follow OS as that is default behavior")
        }
    }
    
    /// Returns the current palette neutral color
    public static var neutral: NeutralColor {
        UITheme.main.active().neutral
    }
    
    /// Returns the neutral palette color of the specified style
    ///
    /// - parameter style: The style to force the neutral color to
    /// - returns: The neutral color of the specified style
    public static func forceNeutral(style: Adaptive) -> PrimaryColor {
        switch style {
        case .light:    return UITheme.main.light.error
        case .dark:     return UITheme.main.dark.error
        case .followOS: fatalError("Cannot force neutral color to follow OS as that is default behavior")
        }
    }
}
