//
//  NMDTextView.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDTextViewAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .text:                     return "text"
        case .keyboardType:             return "keyboardType"
        case .returnKeyType:            return "returnKeyType"
        case .isEditable:               return "isEditable"
        case .isSelectable:             return "isSelectable"
        case .autocapitalizationType:   return "autocapitalizationType"
        case .autocorrectionType:       return "autocorrectionType"
        case .textContainerInset:       return "textContainerInset"
        case .isScrollEnabled:          return "isScrollEnabled"
        }
    }
    
    case text(String?)
    case keyboardType(UIKeyboardType)
    case returnKeyType(UIReturnKeyType)
    case isEditable(Bool)
    case isSelectable(Bool)
    case autocapitalizationType(UITextAutocapitalizationType)
    case autocorrectionType(UITextAutocorrectionType)
    case textContainerInset(UIEdgeInsets)
    case isScrollEnabled(Bool)
}

open class NMDTextView: UITextView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .labelAttributes([
            .textColor(.background.onColor)
        ]),
        .textViewAttributes([
            .isEditable(true),
            .isSelectable(true)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: attributes.viewFrame ?? .zero, textContainer: nil)
        setup(attributes)
    }
    
    public init(
        _ text: String? = nil,
        isEditable: Bool = true
    ) {
        super.init(frame: .zero, textContainer: nil)
        var textAttrs: [NMDTextViewAttribute] = [
            .isEditable(isEditable)
        ]
        if let text { textAttrs.append(.text(text)) }
        setup([.textViewAttributes(textAttrs)])
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDTextViewAttribute {
            setTextViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDLabelAttribute {
            setTextAttribute(attribute)
        }
    }
    
    public func setTextAttribute(_ attribute: NMDLabelAttribute) {
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
        default:
            break
        }
    }
    
    public func setTextViewAttribute(_ attribute: NMDTextViewAttribute) {
        switch attribute {
        case .text(let text):
            self.text = text
        case .keyboardType(let type):
            keyboardType = type
        case .returnKeyType(let type):
            returnKeyType = type
        case .isEditable(let editable):
            isEditable = editable
        case .isSelectable(let selectable):
            isSelectable = selectable
        case .autocapitalizationType(let type):
            autocapitalizationType = type
        case .autocorrectionType(let type):
            autocorrectionType = type
        case .textContainerInset(let inset):
            textContainerInset = inset
        case .isScrollEnabled(let enabled):
            isScrollEnabled = enabled
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
