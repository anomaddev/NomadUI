//
//  NMDTextField.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDTextFieldAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .text:                     return "text"
        case .placeholder:              return "placeholder"
        case .keyboardType:             return "keyboardType"
        case .returnKeyType:            return "returnKeyType"
        case .isSecureTextEntry:        return "isSecureTextEntry"
        case .autocapitalizationType:   return "autocapitalizationType"
        case .autocorrectionType:       return "autocorrectionType"
        case .borderStyle:              return "borderStyle"
        case .clearButtonMode:          return "clearButtonMode"
        case .textContentType:          return "textContentType"
        }
    }
    
    case text(String?)
    case placeholder(String?)
    case keyboardType(UIKeyboardType)
    case returnKeyType(UIReturnKeyType)
    case isSecureTextEntry(Bool)
    case autocapitalizationType(UITextAutocapitalizationType)
    case autocorrectionType(UITextAutocorrectionType)
    case borderStyle(UITextField.BorderStyle)
    case clearButtonMode(UITextField.ViewMode)
    case textContentType(UITextContentType?)
}

open class NMDTextField: UITextField, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .labelAttributes([
            .textColor(.background.onColor)
        ]),
        .textFieldAttributes([
            .borderStyle(.roundedRect)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: attributes.viewFrame ?? .zero)
        setup(attributes)
    }
    
    public init(
        _ text: String? = nil,
        placeholder: String? = nil,
        keyboard: UIKeyboardType = .default
    ) {
        super.init(frame: .zero)
        var fieldAttrs: [NMDTextFieldAttribute] = [
            .keyboardType(keyboard)
        ]
        if let text { fieldAttrs.append(.text(text)) }
        if let placeholder { fieldAttrs.append(.placeholder(placeholder)) }
        setup([.textFieldAttributes(fieldAttrs)])
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDTextFieldAttribute {
            setTextFieldAttribute(attribute)
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
        case .autoAdjustFont(let adjust):
            adjustsFontSizeToFitWidth = adjust
        default:
            break
        }
    }
    
    public func setTextFieldAttribute(_ attribute: NMDTextFieldAttribute) {
        switch attribute {
        case .text(let text):
            self.text = text
        case .placeholder(let placeholder):
            self.placeholder = placeholder
        case .keyboardType(let type):
            keyboardType = type
        case .returnKeyType(let type):
            returnKeyType = type
        case .isSecureTextEntry(let secure):
            isSecureTextEntry = secure
        case .autocapitalizationType(let type):
            autocapitalizationType = type
        case .autocorrectionType(let type):
            autocorrectionType = type
        case .borderStyle(let style):
            borderStyle = style
        case .clearButtonMode(let mode):
            clearButtonMode = mode
        case .textContentType(let type):
            textContentType = type
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
