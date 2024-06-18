//
//  BasicController.swift
//
//
//  Created by Justin Ackermann on 5/9/24.
//

// Core iOS
import UIKit

// Nomad
import NomadUtilities

open class BasicController: UIViewController {
    
    lazy var dismissTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    public var isDismissKeysEnabled: Bool = false {
        didSet {
            if isDismissKeysEnabled
            { self.view.addGestureRecognizer(dismissTap) }
            else { self.view.removeGestureRecognizer(dismissTap) }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background.color
        
    }
    
    // MARK: Actions
    @objc open func endEditing(_ sender: Any!)
    { view.endEditing(true) }
    
    @objc func appleIDStateDidRevoked(_ notification: Notification) {
        // Make sure user signed in with Apple
        do { } // TODO: Log Out }
        catch { self.handle(error) }
    }
    
    @objc open func goBack(_ sender: Any!) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: TextFieldDelegates
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isDismissKeysEnabled = true
        return true
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        isDismissKeysEnabled = false
    }

    
    open func handle(_ error: Error) {
        error.explain()
    }
}
