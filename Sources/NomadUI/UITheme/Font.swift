//
//  Font.swift
//
//
//  Created by Justin Ackermann on 5/9/24.
//

import UIKit

public enum FontFamily: String, CaseIterable {
    
    case Bison
    
    case FuturaPT
    
    case HelveticaNeue
    
    case PathwayExtreme
    case PTSans
    
    case Raleway
    case Rubik
    
    var enabled: [Font] {
        switch self {
        case .Bison:       
            return [.Bold]
            
        case .FuturaPT:
            return [.Book, .Medium, .MediumOblique, .Bold, .BoldOblique]
            
        case .HelveticaNeue:
            return [.Bold, .Medium, .Regular, .Light, .Thin]
            
        case .PathwayExtreme:
            return [.Bold, .ExtraBold, .ExtraBoldItalic, .Medium, .Regular, .SemiBold, .SemiBoldItalic]
            
        case .PTSans:
            return [.Bold, .BoldItalic, .Regular, .Italic]
            
        case .Raleway:
            return [.Bold, .ExtraBold, .ExtraLight, .ExtraLightItalic, .Light, .LightItalic, .Medium, .MediumItalic, .Regular, .SemiBold, .SemiBoldItalic, .Thin, .ThinItalic, .Black, .BlackItalic]
            
        case .Rubik:
            return [.Black, .BlackItalic, .Bold, .BoldItalic, .ExtraBold, .ExtraBoldItalic, .Italic, .Light, .LightItalic, .MediumItalic, .Regular, .SemiBold, .SemiBoldItalic]
        }
    }
}

public enum Font: String, CaseIterable {
    
    public static var Key: NSAttributedString.Key = .font
    public static var Strikethrough: NSAttributedString.Key = .strikethroughStyle
    
    //    case Default
    case Regular
    case Thin
    case Light
    case Medium
    case Bold
    
    case Black
    case BlackItalic
    case BoldItalic
    case ExtraLight
    case ExtraLightItalic
    case LightItalic
    case Italic
    case SemiBold
    case SemiBoldItalic
    case ThinItalic
    case MediumItalic
    case ExtraBoldItalic
    case ExtraBold
    
    /// Extra
    case Book
    case MediumOblique
    case BoldOblique
    
    // TODO: Make throwing function? 
    public func getFont(size: CGFloat? = 14,
                        alternative: Bool! = false) -> UIFont
    {
        guard let size = size else { return UIFont(name: "HelveticaNeue", size: 14)! }
        let fontFamily = alternative ? UITheme.main.altFont : UITheme.main.appFont
        
        guard fontFamily.enabled.contains(self)
        else {
            print("INVALID FONT WEIGHT: \(self.rawValue)")
            print("Choose from one of the following fonts weights:")
            for font in fontFamily.enabled {
                print("• \(font.rawValue)")
            }
            print()
            fatalError("\(fontFamily.rawValue) does not support \(self.rawValue)")
        }
        
        let thefont = "\(fontFamily.rawValue)-\(self.rawValue)"
        guard let font = UIFont(name: thefont, size: size)
        else {
            let fallback = fontFamily != .HelveticaNeue ? "\(fontFamily.rawValue)-\(Font.Regular.rawValue)" : fontFamily.rawValue
            guard let font = UIFont(name: fallback, size: size)
            else {
                print("The Font: \(thefont)")
                print("The Fallback: \(fallback)")
                fatalError("You are attempting to get an invalid font and the fallback failed")
            } // THROW:
            return font
        }
        return font
    }
}
    //        switch fontFamily {
    //        case .HelveticaNeue:
    //            switch self {
    //            case .Thin:     return UIFont(name: "HelveticaNeue-Thin", size: size)!
    //            case .Light:    return UIFont(name: "HelveticaNeue-Light", size: size)!
    //            case .Medium:   return UIFont(name: "HelveticaNeue-Medium", size: size)!
    //            case .Bold:     return UIFont(name: "HelveticaNeue-Bold", size: size)!
    //
    //            default:        return UIFont(name: "HelveticaNeue", size: size)!
    //            }
    //
    //        case .PTSans:
    //            switch self {
    //            case .Italic:   return UIFont(name: "PTSans-Italic", size: size)!
    //            case .Bold:     return UIFont(name: "PTSans-Bold", size: size)!
    //            case .BoldItalic: return UIFont(name: "PTSans-BoldItalic", size: size)!
    //
    //            default:        return UIFont(name: "PTSans-Regular", size: size)!
    //            }
    //
    //        case .Raleway:
    //            switch self {
    //            case .Bold:     return UIFont(name: "Raleway-Bold", size: size)!
    //            case .BoldItalic: return UIFont(name: "Raleway-BoldItalic", size)!
    //            default:        return UIFont(name: "Raleway-Regular", size: size)!
    //            }
    //        }
    //    }
    
//    public static func loadFonts(active: [FontFamily]! = FontFamily.allCases) {
//        let fontNames = active
//            .filter {
//                $0 != .HelveticaNeue
//                /// accounting for system fonts not in Nomad bundle
//            }
//            .map { name in Font.allCases.map { "\(name.rawValue)-\($0.rawValue)" }}
//            .reduce([], +)
//        
//        for fontName in fontNames
//        { try? loadFont(withName: fontName) }
//    }
//    
//    private static func loadFont(withName fontName: String) throws {
//        guard let asset = NSDataAsset(name: "Fonts/\(fontName)", bundle: Bundle.module),
//              let provider = CGDataProvider(data: asset.data as NSData),
//              let font = CGFont(provider),
//              CTFontManagerRegisterGraphicsFont(font, nil) else {
//            print(fontName)
//            throw NSError()
//        }
//        print("LOADED FONT: \(fontName)")
//    }
//}
