//
//  UIImageViewExtension.swift
//  eprimora
//
//  Created by Rafael Escaleira on 25/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func setColor(color: UIColor) {
        
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
