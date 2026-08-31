//
//  NMDCollectionView.swift
//
//
//  Created by Justin Ackermann on 8/31/26.
//

import UIKit

public enum NMDCollectionViewAttribute: NMDAttribute {
    
    public var value: String {
        switch self {
        case .itemSize:                 return "itemSize"
        case .minimumLineSpacing:       return "minimumLineSpacing"
        case .minimumInteritemSpacing:  return "minimumInteritemSpacing"
        case .scrollDirection:          return "scrollDirection"
        case .sectionInset:             return "sectionInset"
        case .isPagingEnabled:          return "isPagingEnabled"
        case .isScrollEnabled:          return "isScrollEnabled"
        case .showsVerticalScrollIndicator:     return "showsVerticalScrollIndicator"
        case .showsHorizontalScrollIndicator:   return "showsHorizontalScrollIndicator"
        }
    }
    
    case itemSize(CGSize)
    case minimumLineSpacing(CGFloat)
    case minimumInteritemSpacing(CGFloat)
    case scrollDirection(UICollectionView.ScrollDirection)
    case sectionInset(UIEdgeInsets)
    case isPagingEnabled(Bool)
    case isScrollEnabled(Bool)
    case showsVerticalScrollIndicator(Bool)
    case showsHorizontalScrollIndicator(Bool)
}

open class NMDCollectionView: UICollectionView, NMDElement {
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.background.color)
        ])
    ]
    
    public convenience init(_ attributes: [NMDAttributeCategory] = []) {
        self.init(layout: UICollectionViewFlowLayout(), attributes)
    }
    
    public init(
        layout: UICollectionViewLayout,
        _ attributes: [NMDAttributeCategory] = []
    ) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup(attributes)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDCollectionViewAttribute {
            setCollectionAttribute(attribute)
        }
    }
    
    public func setCollectionAttribute(_ attribute: NMDCollectionViewAttribute) {
        let flow = collectionViewLayout as? UICollectionViewFlowLayout
        
        switch attribute {
        case .itemSize(let size):
            flow?.itemSize = size
        case .minimumLineSpacing(let spacing):
            flow?.minimumLineSpacing = spacing
        case .minimumInteritemSpacing(let spacing):
            flow?.minimumInteritemSpacing = spacing
        case .scrollDirection(let direction):
            flow?.scrollDirection = direction
        case .sectionInset(let inset):
            flow?.sectionInset = inset
        case .isPagingEnabled(let paging):
            isPagingEnabled = paging
        case .isScrollEnabled(let enabled):
            isScrollEnabled = enabled
        case .showsVerticalScrollIndicator(let shows):
            showsVerticalScrollIndicator = shows
        case .showsHorizontalScrollIndicator(let shows):
            showsHorizontalScrollIndicator = shows
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class NMDCollectionCell: UICollectionViewCell, NMDElement {
    
    public static func getId() -> String { cellId }
    open class var cellId: String { return "collectionCell" }
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.background.color)
        ])
    ]
    
    public static func register(on collection: UICollectionView) {
        collection.register(self, forCellWithReuseIdentifier: cellId)
    }
    
    public static func dequeue(
        on collection: UICollectionView,
        for index: IndexPath
    ) -> Self? {
        collection.dequeueReusableCell(withReuseIdentifier: cellId, for: index) as? Self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup(defaultAttributes)
        layout()
    }
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: .zero)
        setup(attributes)
        layout()
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
            if case .backgroundColor(let color) = attribute {
                contentView.backgroundColor = color
            }
        }
    }
    
    /// Hook for subclasses to compose content after attributes are applied.
    open func layout() {}
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
