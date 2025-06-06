//
//  NMDView.swift
//  
//
//  Created by Justin Ackermann on 5/9/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

// Utilities
import Cartography

public enum NMDViewAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .tag:          return "tag"
            
        case .frame:        return "frame"
        case .setHeight:    return "setHeight"
        case .setWidth:     return "setWidth"
        case .setSize:      return "setSize"
            
        case .alpha:        return "alpha"
        case .backgroundColor: return "backgroundColor"
        case .tintColor:    return "tintColor"
        case .contentMode:  return "contentMode"
            
        case .clipsToBounds: return "clipsToBounds"
        case .cornerRadius: return "cornerRadius"
        case .corners:      return "corners"
            
        case .borderWidth:  return "borderWidth"
        case .borderColor:  return "borderColor"
            
        case .shadowColor:  return "shadowColor"
        case .shadowOffset: return "shadowOffset"
        case .shadowRadius: return "shadowRadius"
        case .shadowOpacity: return "shadowOpacity"
            
        case .isHidden:     return "isHidden"
        case .isUserInteractionEnabled: return "isUserInteractionEnabled"
        }
    }
    
    case tag(Int)
    
    case frame(CGRect)
    case setHeight(CGFloat)
    case setWidth(CGFloat)
    case setSize(CGSize)
    
    case alpha(CGFloat)
    case backgroundColor(UIColor)
    case tintColor(UIColor)
    case contentMode(UIView.ContentMode)
    
    case clipsToBounds(Bool)
    case cornerRadius(CGFloat)
    case corners(CACornerMask)
    
    case borderWidth(CGFloat)
    case borderColor(UIColor)
    
    case shadowColor(UIColor)
    case shadowOffset(CGSize)
    case shadowRadius(CGFloat)
    case shadowOpacity(Float)
    
    case isHidden(Bool)
    case isUserInteractionEnabled(Bool)
    
}

open class NMDView: UIView, NMDElement {
    
    var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.primary.color)
        ])
    ]
    
    public init(_ color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
    }
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        let given = attributes.reduce([]) { $0 + $1.attributes }
        if let frame = given.first(where: { $0.value == "frame" }) as? NMDViewAttribute {
            switch frame {
            case .frame(let rect): super.init(frame: rect)
            default: super.init(frame: .zero)
            }
        } else { super.init(frame: .zero) }
        
        setup(attributes)
    }
    
    public init(view attributes: [NMDViewAttribute] = []) {
        if let frame = attributes.first(where: { $0.value == "frame" }) as? NMDViewAttribute {
            switch frame {
            case .frame(let rect): super.init(frame: rect)
            default: super.init(frame: .zero)
            }
        } else { super.init(frame: .zero) }
        
        setup([.viewAttributes(attributes)])
    }
    
    internal func setup(_ attributes: [NMDAttributeCategory]) {
        let given = attributes.reduce([]) { $0 + $1.attributes }
        let defaults = defaultAttributes
            .reduce([]) { $0 + $1.attributes }
            .filter { atrib -> Bool in !given.contains(where: { $0.value == atrib.value })}
    
        let all = given + defaults
        all.forEach {
            if let attribute = $0 as? NMDViewAttribute
            { setViewAttribute(attribute) }
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

public class Spacer: NMDView {
    public init(w: CGFloat? = nil, h: CGFloat? = nil) {
        var attributes: [NMDViewAttribute] = []
        if let w = w { attributes.append(.setWidth(w)) }
        if let h = h { attributes.append(.setHeight(h)) }
        
        super.init([.viewAttributes(attributes)])
        backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

extension UIView {
    public func setViewAttribute(_ attribute: NMDViewAttribute) {
        switch attribute {
            
            // Object descriptors
        case .tag(let t):
            tag = t
            
            // Sizing
        case .setHeight(let height):
            constrain(self) { $0.height ~== height }
            
        case .setWidth(let width):
            constrain(self) { $0.width ~== width }
            
        case .setSize(let size):
            constrain(self) {
                $0.height ~== size.height
                $0.width ~== size.width
            }
            
            // Theming
        case .alpha(let alph):
            alpha = alph
            
        case .backgroundColor(let color):
            backgroundColor = color
            
        case .tintColor(let tint):
            tintColor = tint
            
        case .contentMode(let mode):
            contentMode = mode
            
            if let isBtn = self as? UIButton 
            { isBtn.imageView?.contentMode = mode }
            
        case .clipsToBounds(let clip):
            layer.masksToBounds = clip
            
        case .cornerRadius(let radius):
            layer.cornerRadius = radius
            layer.masksToBounds = true
            
        case .corners(let corners):
            layer.maskedCorners = corners
            
        case .borderWidth(let width):
            layer.borderWidth = width
            
        case .borderColor(let color):
            layer.borderColor = color.cgColor
            
            // TODO: Shadows
            
        case .isHidden(let hidden):
            isHidden = hidden
            
        case .isUserInteractionEnabled(let interaction):
            isUserInteractionEnabled = interaction
            
        default: break
        }
    }
}
