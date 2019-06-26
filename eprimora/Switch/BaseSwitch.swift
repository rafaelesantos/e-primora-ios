//
//  BaseSwitch.swift
//  eprimora
//
//  Created by Rafael Escaleira on 23/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public typealias SwitchValueChangeHook  = (_ value: Bool) -> Void

@IBDesignable open class BaseSwitch: UIControl {
    
    open var valueChange : SwitchValueChangeHook?
    @IBInspectable open var animateDuration : Double = 0.4
    
    @IBInspectable open var isOn : Bool {
        set { on = newValue }
        get { return on }
    }
    
    internal var on : Bool = true
    
    internal var sizeScale: CGFloat { return min(self.bounds.width, self.bounds.height) / 100.0 }
    
    open override var frame: CGRect {
        
        didSet {
            guard frame.size != oldValue.size else { return }
            resetView()
        }
    }
    
    open override var bounds: CGRect {
        
        didSet {
            guard frame.size != oldValue.size else { return }
            resetView()
        }
    }
    
    final public func setOn(_ on: Bool, animate: Bool = true) {
        
        guard on != isOn else { return }
        changeValue()
    }
    
    convenience public init() { self.init(frame: CGRect(x: 0, y: 0, width: 80, height: 40)) }
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        setUpView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setUpView()
    }
    
    internal func resetView() {
        
        gestureRecognizers?.forEach(self.removeGestureRecognizer)
        layer.sublayers?.forEach( { $0.removeFromSuperlayer()})
        setUpView()
    }
    
    internal func setUpView(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseSwitch.changeValue))
        self.addGestureRecognizer(tap)
        
        for view in self.subviews { view.removeFromSuperview() }
    }
    
    @objc internal func changeValue(){
        
        on = !on
        valueChange?(!isOn)
        sendActions(for: UIControl.Event.valueChanged);
    }
}
