//
//  NMDElement.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

import UIKit

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

/// A UIKit view configured from typed attribute lists.
///
/// Conformers supply `defaultAttributes` and `apply(_:)`. Call `setup(_:)`
/// (or rely on `init(_ attributes:)`) to merge caller attributes over defaults
/// and apply them. New element types should add an attribute enum, an
/// `NMDAttributeCategory` case, and an `apply` implementation.
public protocol NMDElement: AnyObject {
    var defaultAttributes: [NMDAttributeCategory] { get set }
    
    func setup(_ attributes: [NMDAttributeCategory])
    func apply(_ attribute: any NMDAttribute)
}

extension NMDElement {
    
    /// Caller attributes first, then defaults whose `value` key was not supplied.
    public func mergedAttributes(_ given: [NMDAttributeCategory]) -> [any NMDAttribute] {
        let givenAttrs = given.reduce(into: [any NMDAttribute]()) { $0.append(contentsOf: $1.attributes) }
        let defaults = defaultAttributes
            .reduce(into: [any NMDAttribute]()) { $0.append(contentsOf: $1.attributes) }
            .filter { atrib in !givenAttrs.contains(where: { $0.value == atrib.value }) }
        return givenAttrs + defaults
    }
    
    public func applyMerged(_ attributes: [NMDAttributeCategory]) {
        mergedAttributes(attributes).forEach { apply($0) }
    }
    
    public func setup(_ attributes: [NMDAttributeCategory]) {
        applyMerged(attributes)
    }
}

public protocol NMDAttribute: Equatable {
    var value: String { get }
}

extension NMDAttribute {
    public static func == (lhs: Self, rhs: Self) -> Bool {
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
    case scrollAttributes([NMDScrollViewAttribute])
    case textFieldAttributes([NMDTextFieldAttribute])
    case textViewAttributes([NMDTextViewAttribute])
    case switchAttributes([NMDSwitchAttribute])
    case sliderAttributes([NMDSliderAttribute])
    case segmentedAttributes([NMDSegmentedControlAttribute])
    case stepperAttributes([NMDStepperAttribute])
    case activityAttributes([NMDActivityIndicatorAttribute])
    case tableAttributes([NMDTableViewAttribute])
    case collectionAttributes([NMDCollectionViewAttribute])
    
    public var attributes: [any NMDAttribute] {
        switch self {
        case .viewAttributes(let attributes):       return attributes
        case .buttonAttributes(let attributes):     return attributes
        case .labelAttributes(let attributes):      return attributes
        case .imageAttributes(let attributes):      return attributes
        case .stackAttributes(let attributes):      return attributes
        case .progressAttributes(let attributes):   return attributes
        case .scrollAttributes(let attributes):     return attributes
        case .textFieldAttributes(let attributes):  return attributes
        case .textViewAttributes(let attributes):   return attributes
        case .switchAttributes(let attributes):     return attributes
        case .sliderAttributes(let attributes):     return attributes
        case .segmentedAttributes(let attributes):  return attributes
        case .stepperAttributes(let attributes):    return attributes
        case .activityAttributes(let attributes):   return attributes
        case .tableAttributes(let attributes):      return attributes
        case .collectionAttributes(let attributes): return attributes
        }
    }
}

extension Array where Element == NMDAttributeCategory {
    
    /// The `NMDViewAttribute.frame` value, if one was supplied.
    public var viewFrame: CGRect? {
        let attrs = reduce(into: [any NMDAttribute]()) { $0.append(contentsOf: $1.attributes) }
        guard let frame = attrs.first(where: { $0.value == "frame" }) as? NMDViewAttribute,
              case .frame(let rect) = frame
        else { return nil }
        return rect
    }
}
