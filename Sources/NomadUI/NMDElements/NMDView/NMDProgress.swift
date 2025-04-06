//
//  File.swift
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
    case cornerRadi(CGFloat)
    case type(ProgressBarType)
    case progress(Float)
    
    public var value: String {
        switch self {
        case .trackColor:  return "progressTrackColor"
        case .progressColor:    return "progressColor"
        case .cornerRadi:       return "progressCornerRadius"
        case .type:             return "progressType"
        case .progress:         return "progress"
        }
    }
}

open class NMDProgress: UIView, NMDElement {
    
    private var modifiers: ConstraintGroup = ConstraintGroup()
    lazy var background: NMDView = NMDView([])
    lazy var progress: NMDView = NMDView([])
    
    var defaultAttributes: [NMDAttributeCategory] = [
        .viewAttributes([
            .backgroundColor(.primary.color)
        ]),
        .progressAttributes([
            .type(.leftToRight)
        ])
    ]
    
    public init(_ attributes: [NMDAttributeCategory] = []) {
        let given = attributes.reduce([]) { $0 + $1.attributes }
        if let frame = given.first(where: { $0.value == "frame" }) as? NMDViewAttribute {
            switch frame {
            case .frame(let rect): super.init(frame: rect)
            default: super.init(frame: .zero)
            }
        } else { super.init(frame: .zero) }
        
        setup(attributes)
    }
    
    func setup(_ attributes: [NMDAttributeCategory]) {
        background.fitTo(self)
        background.add(progress)
        progress.centerOn(background, axis: [.vertical])
        
        let given = attributes.reduce([]) { $0 + $1.attributes }
        let defaults = defaultAttributes
            .reduce([]) { $0 + $1.attributes }
            .filter { atrib -> Bool in !given.contains(where: { $0.value == atrib.value })}
        
        let all = given + defaults
        all.forEach {
            if let attribute = $0 as? NMDViewAttribute
            { setViewAttribute(attribute) }
            
            if let attribute = $0 as? NMDProgressAttribute
            { setProgressAttribute(attribute) }
        }
        
        sizeToFit()
        layoutIfNeeded()
        
        background.bringSubviewToFront(progress)
    }
    
    public func setProgressAttribute(_ attribute: NMDProgressAttribute) {
        switch attribute {
            
            // Progress
        case .trackColor(let color):
            background.backgroundColor = color
            
        case .progressColor(let color):
            progress.backgroundColor = color
            
        case .cornerRadi(let radius):
            background.layer.cornerRadius = radius
            background.layer.masksToBounds = true
            
            progress.layer.cornerRadius = radius
            progress.layer.masksToBounds = true
            
        case .type(let progressType):
            switch progressType {
            case .leftToRight:
                constrain(progress)
                { progress in
                    let superview = progress.superview!
                    progress.left ~== superview.left
                }
                
                constrain(progress, replace: modifiers)
                { progress in progress.width ~== 0 }
                
            default: break
            }
            
        case .progress(let prog):
            setProgress(prog.cg)
        }
    }
    
    public func setProgress(_ prog: CGFloat, duration: Double! = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            constrain(self.progress, replace: self.modifiers)
            { progress in progress.width ~== progress.superview!.width * prog }
            
            self.layoutIfNeeded()
        })
    }
    
    required public init?(coder: NSCoder)
    { fatalError("init(coder:) has not been implemented") }
}
