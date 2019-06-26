//
//  HomeApplianceSelectionCell.swift
//  eprimora
//
//  Created by Rafael Escaleira on 24/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class HomeApplianceSelectionCell: UITableViewCell {
    
    @IBOutlet weak private var productNameLabel: UILabel!
    @IBOutlet weak private var productConvenientLabel: UILabel!
    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var selectSwitch: SimpleSwitch!
    
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var hourButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.productView.setViewGlow(shadowColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), shadowRadius: 5, shadowOpacity: 0.75)
    }
    
    public func setCell(productName: NSString?, productConvenient: NSString?, productImageData: NSData) {
        
        self.productNameLabel.text = (productName as String?)?.lowercased().capitalized
        self.productConvenientLabel.text = (productConvenient as String?)?.lowercased().capitalized
        self.productImage.image = UIImage(data: productImageData as Data)
        self.productImage.setColor(color: .white)
    }
    
    public func setIndexButton(index: Int) {
        
        self.powerButton.tag = index
        self.amountButton.tag = index
        self.hourButton.tag = index
        self.dayButton.tag = index
    }
    
    public func setTitleButton(titlePower: String?, titleAmount: String?, titleHour: String?, titleDay: String?) {
        
        self.powerButton.setTitle(titlePower, for: .normal)
        self.amountButton.setTitle(titleAmount, for: .normal)
        self.hourButton.setTitle(titleHour, for: .normal)
        self.dayButton.setTitle(titleDay, for: .normal)
    }
    
    public func setButtonBackgroundColor(isShow: [Bool]) {
        
        if #available(iOS 13.0, *) {
            self.amountButton.backgroundColor = isShow[1] == true ? UIColor.systemOrange : UIColor.secondarySystemFill
            self.amountButton.setTitleColor(isShow[1] == true ? .white : UIColor.systemOrange, for: .normal)
        }
        if #available(iOS 13.0, *) {
            self.hourButton.backgroundColor = isShow[2] == true ? UIColor.systemPurple : UIColor.secondarySystemFill
            self.hourButton.setTitleColor(isShow[2] == true ? .white : UIColor.systemPurple, for: .normal)
        }
        if #available(iOS 13.0, *) {
            self.dayButton.backgroundColor = isShow[3] == true ? #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1) : UIColor.secondarySystemFill
            self.dayButton.setTitleColor(isShow[3] == true ? .white : #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1), for: .normal)
        }
    }
}
