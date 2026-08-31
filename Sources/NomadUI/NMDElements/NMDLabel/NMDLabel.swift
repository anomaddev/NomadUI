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
    
    var generic: Generic {
        switch self {
        case .H1: return .H1
        case .H2: return .H2
        case .H3: return .H3
        case .H4: return .H4
        case .H5: return .H5
        case .H6: return .H6
        case .B: return .B
        case .M: return .M
        case .P: return .P
        }
    }
    
    enum Generic: Hashable {
        case H1,
             H2,
             H3,
             H4,
             H5,
             H6,
             B,
             M,
             P
    }
}

public enum NMDLabelAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .text:                 return "text"
        case .textColor:            return "textColor"
        case .textAlignment:        return "textAlignment"
        case .font:                 return "font"
        case .altfont:              return "font"
        case .style:                return "font"
        case .numberOfLines:        return "numberOfLines"
        case .autoAdjustFont:       return "autoAdjustFont"
        case .minimumScaleFactor:   return "minimumScaleFactor"
        case .textPadding:          return "textPadding"
        }
    }
    
    case text(String)
    case textColor(UIColor)
    case textAlignment(NSTextAlignment)
    case font(weight: Font, size: CGFloat)
    case altfont(weight: Font, size: CGFloat)
    case style(NMDLabelStyle, alternative: Bool)
    case numberOfLines(Int)
    case autoAdjustFont(Bool)
    case minimumScaleFactor(CGFloat)
    case textPadding(UIEdgeInsets)
    
}

open class NMDLabel: UILabel, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .labelAttributes([
            .textColor(.background.onColor)
        ])
    ]
    
    var padding: UIEdgeInsets = .zero
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
    }
    
    public init(
        _ text: String? = nil,
        style: NMDLabelStyle = .H3,
        alternative: Bool = false,
        color: UIColor = .background.onColor,
        align: NSTextAlignment = .left,
        height: CGFloat? = nil,
        numberOfLines: Int = 1
    ) {
        super.init(frame: .zero)
        
        var labelAttrs: [NMDLabelAttribute] = [
            .textColor(color),
            .textAlignment(align),
            .style(style, alternative: alternative),
            .numberOfLines(style.generic == .P ? 0 : numberOfLines)
        ]
        if let text {
            labelAttrs.append(.text(text))
        }
        
        var categories: [NMDAttributeCategory] = [
            .labelAttributes(labelAttrs)
        ]
        if let height {
            categories.append(.viewAttributes([.setHeight(height)]))
        }
        setup(categories)
    }
    
    open func setup(_ attributes: [NMDAttributeCategory]) {
        applyMerged(attributes)
        sizeToFit()
        layoutIfNeeded()
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDLabelAttribute {
            setLabelAttribute(attribute)
        }
    }
    
    public func setLabelAttribute(_ attribute: NMDLabelAttribute) {
        switch attribute {
            
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
            
        case .style(let style, let alternative):
            font = style.uiFont(alternative: alternative)
            if style.generic == .P { numberOfLines = 0 }
            
        case .numberOfLines(let lines):
            numberOfLines = lines
            
        case .autoAdjustFont(let adjust):
            adjustsFontSizeToFitWidth = adjust
            minimumScaleFactor = 0.75
            
        case .minimumScaleFactor(let factor):
            minimumScaleFactor = factor
            
        case .textPadding(let insets):
            padding = insets
        }
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    public override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class Paragraph: NMDLabel {
    public init(
        _ text: String? = nil,
        size: CGFloat = 15
    ) {
        super.init(
            text,
            style: .P(size: size),
            align: .justified,
            numberOfLines: 0
        )
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class SubHeader: NMDLabel {
    public init(
        _ text: String? = nil,
        size: CGFloat = 15
    ) {
        super.init(
            text,
            style: .B(size: size),
            align: .justified,
            numberOfLines: 0
        )
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class List: NMDLabel {
    public init(
        description: String? = nil,
        fontSize: CGFloat = 15,
        listItems: [LabelListItem] = []
    ) {
        super.init(
            description,
            style: .P(size: fontSize),
            align: .left,
            numberOfLines: 0
        )
        
        text = nil
        let list = description?.mutable(attributes: [
            .font:              Font.Regular.getFont(size: fontSize),
            .foregroundColor:   UIColor.background.onColor
        ])
        
        for (i, item) in listItems.enumerated() {
            let title = item.title != nil ? "\(item.title ?? ""):  " : ""
            let listNum = "\n\n\(i + 1).  \(title)".mutable(attributes: [
                .font:              Font.Bold.getFont(size: fontSize),
                .foregroundColor:   UIColor.background.onColor
            ])
            
            listNum.append(item.item.mutable(attributes: [
                .font:              Font.Regular.getFont(size: fontSize),
                .foregroundColor:   UIColor.background.onColor
            ]))
            
            list?.append(listNum)
        }
        
        attributedText = list
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

public struct LabelListItem {
    public var title: String?
    public var item: String
    
    public init(title: String? = nil, item: String) {
        self.title = title
        self.item = item
    }
}
