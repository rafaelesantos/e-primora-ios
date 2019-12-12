//
//  SignInViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var logoImageHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc private func keyboardWillChange(notification: Notification) {
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            
            self.view.layoutIfNeeded()
            self.logoImageHeight.constant = 0
            
            UIView.animate(withDuration: 1, animations: { self.view.layoutIfNeeded() })
        }
            
        else if notification.name == UIResponder.keyboardWillHideNotification {
            
            self.view.layoutIfNeeded()
            self.logoImageHeight.constant = 150
            
            UIView.animate(withDuration: 1, animations: { self.view.layoutIfNeeded() })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Button Action
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Gesture Recognizer

extension SignInViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        
        return false
    }
}
