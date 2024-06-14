//
//  NMDLabel.swift
//
//
//  Created by Justin Ackermann on 3/29/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

// Utilities
import Cartography

public enum NMDLabelStyle: Hashable {
    case H1, 
         H2,
         H3,
         H4,
         H5,
         H6,
         
         B(size: CGFloat),
         M(size: CGFloat),
         P(size: CGFloat)
}

public enum NMDLabelAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .text:         return "text"
        case .textColor:    return "textColor"
        case .textAlignment: return "textAlignment"
        case .font:         return "font"
        case .altfont:      return "altfont"
        case .numberOfLines: return "numberOfLines"
        case .autoAdjustFont: return "autoAdjustFont"
        case .minimumScaleFactor: return "minimumScaleFactor"
        }
    }
    
    case text(String)
    case textColor(UIColor)
    case textAlignment(NSTextAlignment)
    case font(weight: Font, size: CGFloat)
    case altfont(weight: Font, size: CGFloat)
    case numberOfLines(Int)
    case autoAdjustFont(Bool)
    case minimumScaleFactor(CGFloat)
    
}

public class NMDLabel: UILabel, NMDElement {
    
    var defaultAttributes: [NMDAttributeCategory] = [
        .labelAttributes([
            .textColor(.background.onColor)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
    }
    
    public init(
        _ text: String? = nil,
        style: NMDLabelStyle! = .H3,
        alternative: Bool! = false,
        color: UIColor! = .background.onColor,
        align: NSTextAlignment! = .left,
        height: CGFloat? = nil
    ) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.textAlignment = align
        self.font = {
            let fontFamily: FontFamily = {
                if alternative { return NomadUI.main.theme.altFont }
                return NomadUI.main.theme.appFont
            }()
            
            return fontFamily.getStyle(style)
        }()
        
        if let height = height { self.setHeight(height) }
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
            
            if let attribute = $0 as? NMDLabelAttribute
            { setLabelAttribute(attribute) }
        }
    }
    
    public func setLabelAttribute(_ attribute: NMDLabelAttribute) {
        switch attribute {
            
            // Label
        case .text(let text):
            self.text = text
            
        case .textColor(let color):
            textColor = color
            
        case .textAlignment(let alignment):
            textAlignment = alignment
            
        case .font(let weight, let size):
            font = weight.getFont(size: size)
            
        case .altfont(let weight, let size):
            font = weight.getFont(size: size, alternative: true)
            
        case .numberOfLines(let lines):
            numberOfLines = lines
            
        case .autoAdjustFont(let adjust):
            adjustsFontSizeToFitWidth = adjust
            minimumScaleFactor = 0.75
            
        case .minimumScaleFactor(let factor):
            minimumScaleFactor = factor
        }
    }
    
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
