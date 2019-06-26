//
//  HomeApplianceSelectionVC.swift
//  eprimora
//
//  Created by Rafael Escaleira on 24/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class HomeApplianceSelectionVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var products: [HomeAppliancesDatabase] = []
    var setProducts: [[Int]] = []
    var setButtons: [[Bool]] = []
    var stateSwitch: [Bool] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIView.animate(withDuration: 0.4) { self.tableView.alpha = 1 }
        
        self.products = self.getHomeAppliance()
        
        for _ in 0...self.products.count - 1 { self.stateSwitch.append(true) }
        
        for product in products {
            
            autoreleasepool {
                
                var buttonSet: [Bool] = []
                buttonSet.append(true)
                buttonSet.append(false)
                buttonSet.append(false)
                buttonSet.append(false)
                
                var buttonState: [Int] = []
                buttonState.append(product.productPower?.intValue ?? 0)
                buttonState.append(Int(arc4random_uniform(5) + 1))
                buttonState.append(Int(arc4random_uniform(5) + 1))
                buttonState.append(Int(arc4random_uniform(5) + 1))
                
                self.setProducts.append(buttonState)
                self.setButtons.append(buttonSet)
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        UIView.animate(withDuration: 0.4) { self.tableView.alpha = 0 }
    }
}
