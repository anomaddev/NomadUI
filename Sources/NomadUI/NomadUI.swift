//
//  NomadUI.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit

public class NomadUI {
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) { 
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        print("LOADED FONT: \(fontName)")
    }
    
    public static func register(fonts: [FontFamily]! = FontFamily.allCases) {
        let fonts = fonts
            .filter {
                $0 != .HelveticaNeue
                /// accounting for system fonts not in Nomad bundle
            }
            .map { name in Font.allCases.map { "\(name.rawValue)-\($0.rawValue)" }}
            .reduce([], +)
            
        fonts.forEach {
            registerFont(bundle: .module, fontName: $0, fontExtension: "ttf")
        }
    }
}
