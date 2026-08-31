//
//  NMDProgress.swift
//
//
//  Created by Justin Ackermann on 8/9/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

// Utilities
import Cartography

public enum ProgressBarType {
    case leftToRight
    case rightToLeft
    case centerOut
    case centerIn
}

public enum NMDProgressAttribute: NMDAttribute {
    
    case trackColor(UIColor)
    case progressColor(UIColor)
    case cornerRadius(CGFloat)
    case type(ProgressBarType)
    case progress(Float)
    
    @available(*, deprecated, renamed: "cornerRadius")
    public static func cornerRadi(_ radius: CGFloat) -> NMDProgressAttribute {
        .cornerRadius(radius)
    }
    
    public var value: String {
        switch self {
        case .trackColor:       return "progressTrackColor"
        case .progressColor:    return "progressColor"
        case .cornerRadius:     return "progressCornerRadius"
        case .type:             return "progressType"
        case .progress:         return "progress"
        }
    }
}

open class NMDProgress: UIView, NMDElement {
    
    private var modifiers: ConstraintGroup = ConstraintGroup()
    private var endModifiers: ConstraintGroup = ConstraintGroup()
    private var progressType: ProgressBarType = .leftToRight
    private var progressValue: CGFloat = 0
    
    lazy var background: NMDView = NMDView([])
    lazy var progress: NMDView = NMDView([])
    lazy var progressEnd: NMDView = NMDView([])
    
    open var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.primary.color)
        ]),
        .progressAttributes([
            .type(.leftToRight)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        super.init(frame: attributes.viewFrame ?? .zero)
        setup(attributes)
    }
    
    open func setup(_ attributes: [NMDAttributeCategory]) {
        background.fitTo(self)
        background.add(progress, progressEnd)
        progress.centerOn(background, axis: [.vertical])
        progressEnd.centerOn(background, axis: [.vertical])
        progressEnd.isHidden = true
        
        applyMerged(attributes)
        
        sizeToFit()
        layoutIfNeeded()
        
        background.bringSubviewToFront(progress)
        background.bringSubviewToFront(progressEnd)
    }
    
    open func apply(_ attribute: any NMDAttribute) {
        if let attribute = attribute as? NMDViewAttribute {
            setViewAttribute(attribute)
        }
        if let attribute = attribute as? NMDProgressAttribute {
            setProgressAttribute(attribute)
        }
    }
    
    public func setProgressAttribute(_ attribute: NMDProgressAttribute) {
        switch attribute {
            
        case .trackColor(let color):
            background.backgroundColor = color
            
        case .progressColor(let color):
            progress.backgroundColor = color
            progressEnd.backgroundColor = color
            
        case .cornerRadius(let radius):
            background.layer.cornerRadius = radius
            background.layer.masksToBounds = true
            
            progress.layer.cornerRadius = radius
            progress.layer.masksToBounds = true
            progressEnd.layer.cornerRadius = radius
            progressEnd.layer.masksToBounds = true
            
        case .type(let type):
            progressType = type
            applyTypeConstraints()
            
        case .progress(let prog):
            setProgress(prog.cg)
        }
    }
    
    public func setProgress(_ prog: CGFloat, duration: Double = 0.3) {
        progressValue = min(max(prog, 0), 1)
        UIView.animate(withDuration: duration, animations: {
            self.applyProgressConstraints()
            self.layoutIfNeeded()
        })
    }
    
    private func applyTypeConstraints() {
        progressEnd.isHidden = progressType != .centerIn
        
        constrain(progress) { bar in
            let superview = bar.superview!
            switch self.progressType {
            case .leftToRight:
                bar.left ~== superview.left
            case .rightToLeft:
                bar.right ~== superview.right
            case .centerOut:
                bar.centerX ~== superview.centerX
            case .centerIn:
                bar.left ~== superview.left
            }
        }
        
        if progressType == .centerIn {
            constrain(progressEnd) { bar in
                let superview = bar.superview!
                bar.right ~== superview.right
            }
        }
        
        applyProgressConstraints()
    }
    
    private func applyProgressConstraints() {
        let value = progressValue
        constrain(progress, replace: modifiers) { bar in
            let superview = bar.superview!
            switch self.progressType {
            case .leftToRight, .rightToLeft, .centerOut:
                bar.width ~== superview.width * value
            case .centerIn:
                bar.width ~== superview.width * (value / 2)
            }
        }
        
        if progressType == .centerIn {
            constrain(progressEnd, replace: endModifiers) { bar in
                let superview = bar.superview!
                bar.width ~== superview.width * (value / 2)
            }
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
