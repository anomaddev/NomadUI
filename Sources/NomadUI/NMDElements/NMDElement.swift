//
//  NMDElement.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit
import Cartography

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

protocol NMDElement {
    var defaultAttributes: [NMDAttributeCategory]
    { get set }
    
    func setup(_ attributes: [NMDAttributeCategory])
}

public protocol NMDAttribute: Equatable {
    static func == (lhs: any NMDAttribute, rhs: any NMDAttribute) -> Bool
    var value: String { get }
}

extension NMDAttribute {
    public static func == (lhs: any NMDAttribute, rhs: any NMDAttribute) -> Bool {
        lhs.value == rhs.value
    }
}

public enum NMDAttributeCategory {
    
    case viewAttributes([NMDViewAttribute])
    case buttonAttributes([NMDButtonAttribute])
    case labelAttributes([NMDLabelAttribute])
    case imageAttributes([NMDImageViewAttribute])
    case stackAttributes([NMDStackAttribute])
    case progressAttributes([NMDProgressAttribute])
    
    var attributes: [any NMDAttribute] {
        switch self {
        case .viewAttributes(let attributes):   return attributes
        case .buttonAttributes(let attributes): return attributes
        case .labelAttributes(let attributes):  return attributes
        case .imageAttributes(let attributes):  return attributes
        case .stackAttributes(let attributes):  return attributes
        case .progressAttributes(let attributes): return attributes
        }
    }
}
