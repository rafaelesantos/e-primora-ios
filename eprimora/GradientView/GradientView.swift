//
//  GradientView.swift
//  eprimora
//
//  Created by Rafael Escaleira on 23/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    @IBInspectable var firstColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var secondColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var startPoint: CGPoint = .init(x: 0, y: 0) {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var endPoint: CGPoint = .init(x: 1, y: 1) {
        didSet { self.setNeedsLayout() }
    }
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    override func layoutSubviews() {
        
        self.gradientLayer = self.layer as? CAGradientLayer
        self.gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        
    }
}

