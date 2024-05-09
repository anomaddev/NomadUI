//
//  NMDElement.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit
import Cartography

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
    
    var attributes: [any NMDAttribute] {
        switch self {
        case .viewAttributes(let attributes):
            return attributes
        }
    }
}
