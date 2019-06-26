//
//  CustomView.swift
//  eprimora
//
//  Created by Rafael Escaleira on 23/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    @IBInspectable var gradient: Bool = true {
        didSet { self.setNeedsLayout() }
    }
    
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
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var clipBound: Bool = true {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
        didSet { self.setNeedsLayout() }
    }
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    override func layoutSubviews() {
        
        if gradient {
            
            self.gradientLayer = self.layer as? CAGradientLayer
            self.gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
            self.gradientLayer.startPoint = startPoint
            self.gradientLayer.endPoint = endPoint
        }
        
        if clipBound {
            
            self.layer.cornerRadius = cornerRadius
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
