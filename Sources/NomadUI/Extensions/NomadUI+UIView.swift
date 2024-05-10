//
//  NomadUI+UIView.swift
//  
//
//  Created by Justin Ackermann on 5/9/24.
//

// Core iOS
import UIKit

// Utilities
import Cartography

extension UIView {
    
    /// Init with a color
    convenience init(color: UIColor)
    { self.init(); backgroundColor = color }
    
    /// Add a list of subviews to a view
    func add(_ subviews: UIView...)
    { subviews.forEach(addSubview) }
    
    /// Remove a subview from a view
    func remove(_ subview: UIView) throws {
        guard let view = subviews.first(where: { $0 == subview })
        else { throw NSError() } // THROW:
        view.removeFromSuperview()
    }
    
    // MARK: - Transforms
    
    /// Rotate a `UIView` by a given number of degrees
    ///
    /// - parameter degrees: A `Float` value to represent the number of degrees to rotate the `UIView`
    /// - parameter animated: A `Bool` value to represent whether the rotation should be animated
    ///
    private func rotate(degrees: Float! = 0, animated: Bool! = true) {
//        Nomad.main.async {
//            let duration: CGFloat = animated ? 0.25 : 0
//            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
//                self.transform = self.transform.rotated(by: degrees.radians.cgfloat)
//                self.layoutIfNeeded()
//            })
//        }
    }
    
    /// Shake a `UIView` over a given duration and repeating a given number of times
    ///
    /// - parameter duration: A `Double` value to represent the duration of the shake motion in seconds
    /// - parameter repeat: a `Float` value to represent the number of shake motions repeated
    ///
    func shake(duration timeDuration: Double = 0.07,
               repeat countRepeat: Float = 3,
               xDist offset: CGFloat = 5) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = timeDuration
        animation.repeatCount = countRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - offset, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + offset, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func fadeOut(with duration: Double! = 0.25) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        })
    }
    
    func fadeIn(with duration: Double! = 0.4) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        })
    }
    
    /// Constraints
    @discardableResult
    func setHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    func setWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    /**
     This function adds the view, on which we call the function, to a specified parent view controller and afixes the constrains to the size of the parent view's margins.
     
     ### Usage Example: ###
     ```swift
     let child = UIView()
     let parent = UIView()
     
     child.fitTo(parent)
     ```
     
     - parameter controller: The `UIViewController` that you want to add this child view on to
     */
    func fitTo(_ controller: UIViewController, padding: UIEdgeInsets! = .zero) {
        controller.view.add(self)
        constrain(self)
        { theview in
            let superview = theview.superview!
            theview.left ~== superview.left + padding.left
            theview.right ~== superview.right - padding.right
            theview.top ~== superview.topMargin + padding.top
            theview.bottom ~== superview.bottomMargin - padding.bottom
        }
        
        controller.view.layoutIfNeeded()
    }
    
    /**
     This function adds the view, on which we call the function, to a specified parent view and afixes the constrains to the size of the parent view.
     
     ### Usage Example: ###
     ```swift
     let child = UIView()
     let parent = UIView()
     
     child.fitTo(parent)
     ```
     
     - parameter view: The `UIView` that you want to add this child view on to
     */
    func fitTo(_ view: UIView, padding: UIEdgeInsets! = .zero) {
        view.add(self)
        constrain(self)
        { theview in
            let superview = theview.superview!
            theview.left ~== superview.left + padding.left
            theview.right ~== superview.right - padding.right
            theview.top ~== superview.top + padding.top
            theview.bottom ~== superview.bottom - padding.bottom
        }
        
        view.layoutIfNeeded()
    }
    
    /// This function will size the a `UIView` with a given parent `UIView`
    ///
    /// - parameter view: The parent `UIView` that you want to match size with
    ///
    func sameSize(as view: UIView) {
        constrain(view, self)
        { parent, child in
            child.width ~== parent.width
            child.height ~== parent.height
        }
        
        view.layoutIfNeeded()
    }
    
    /// This function will size width of a `UIView` with a given parent `UIView` width
    ///
    /// - parameter view: The parent `UIView` that you want to match width with
    ///
    func sameWidth(as view: UIView) {
        constrain(view, self)
        { parent, child in
            child.width ~== parent.width
        }
        
        view.layoutIfNeeded()
    }
    
    /// This function will size height of a `UIView` with a given parent `UIView` height
    ///
    /// - parameter view: The parent `UIView` that you want to match height with
    ///
    func sameHeight(as view: UIView) {
        constrain(view, self)
        { parent, child in
            child.height ~== parent.height
        }
        
        view.layoutIfNeeded()
    }
}
