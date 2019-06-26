//
//  UIViewExtension.swift
//  eprimora
//
//  Created by Rafael Escaleira on 25/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

extension UIView {
    
    public func setViewGlow(shadowColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float) {
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
    }
}
