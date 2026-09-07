//
//  NMDView.swift
//
//
//  Created by Justin Ackermann on 5/9/24.
//

// Core iOS
import UIKit
import ObjectiveC

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
            
        case .subviews:     return "subviews"
            
        case .accessibilityLabel:       return "accessibilityLabel"
        case .accessibilityHint:        return "accessibilityHint"
        case .isAccessibilityElement:   return "isAccessibilityElement"
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
    
    case subviews([UIView])
    
    case accessibilityLabel(String?)
    case accessibilityHint(String?)
    case isAccessibilityElement(Bool)
    
    /// Compare by attribute key, matching `NMDAttribute` default equality.
    /// Required because `subviews` carries `[UIView]`, which blocks automatic
    /// `Equatable` synthesis.
    public static func == (lhs: NMDViewAttribute, rhs: NMDViewAttribute) -> Bool {
        lhs.value == rhs.value
    }
    
}

open class NMDView: UIView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.primary.color)
        ])
    ]
    
    public init(_ color: UIColor) {
        super.init(frame: .zero)
        setup([.viewAttributes([.backgroundColor(color)])])
    }
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: attributes.viewFrame ?? .zero)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

public class Spacer: NMDView {
    public init(w: CGFloat? = nil, h: CGFloat? = nil) {
        var attributes: [NMDViewAttribute] = [
            .backgroundColor(.clear)
        ]
        if let w = w { attributes.append(.setWidth(w)) }
        if let h = h { attributes.append(.setHeight(h)) }
        
        super.init([.viewAttributes(attributes)])
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

private struct NMDViewShadowFlag {
    static var key: UInt8 = 0
}

extension UIView {
    
    fileprivate var hasConfiguredShadow: Bool {
        get { objc_getAssociatedObject(self, &NMDViewShadowFlag.key) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &NMDViewShadowFlag.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public func setViewAttribute(_ attribute: NMDViewAttribute) {
        switch attribute {
            
            // Object descriptors
        case .tag(let t):
            tag = t
            
        case .frame(let rect):
            frame = rect
            
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
            if !hasConfiguredShadow {
                layer.masksToBounds = true
            }
            
        case .corners(let corners):
            layer.maskedCorners = corners
            
        case .borderWidth(let width):
            layer.borderWidth = width
            
        case .borderColor(let color):
            layer.borderColor = color.cgColor
            
        case .shadowColor(let color):
            layer.shadowColor = color.cgColor
            hasConfiguredShadow = true
            layer.masksToBounds = false
            
        case .shadowOffset(let offset):
            layer.shadowOffset = offset
            hasConfiguredShadow = true
            layer.masksToBounds = false
            
        case .shadowRadius(let radius):
            layer.shadowRadius = radius
            hasConfiguredShadow = true
            layer.masksToBounds = false
            
        case .shadowOpacity(let opacity):
            layer.shadowOpacity = opacity
            hasConfiguredShadow = true
            layer.masksToBounds = false
            
        case .isHidden(let hidden):
            isHidden = hidden
            
        case .isUserInteractionEnabled(let interaction):
            isUserInteractionEnabled = interaction
            
        case .subviews(let views):
            views.forEach { addSubview($0) }
            
        case .accessibilityLabel(let label):
            accessibilityLabel = label
            
        case .accessibilityHint(let hint):
            accessibilityHint = hint
            
        case .isAccessibilityElement(let isElement):
            isAccessibilityElement = isElement
        }
    }
}
