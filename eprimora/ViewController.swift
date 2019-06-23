//
//  ViewController.swift
//  eprimora
//
//  Created by Rafael Escaleira on 08/04/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if HomeAppliancesDatabase.query().count() == 0 { self.parseProductInformation() }
    }
    
    private func parseProductInformation() {
        
        guard let path = Bundle.main.path(forResource: "PotenciaMedia", ofType: ".json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [Any] else { return }
            
            for product in array {
                
                autoreleasepool {
                    
                    guard let productDict = product as? [String: Any] else { return }
                    let productDatabase = HomeAppliancesDatabase()
                    
                    productDatabase.productID = productDict["id"] as? NSNumber
                    productDatabase.productName = productDict["nomeProduto"] as? NSString
                    productDatabase.productCategories = productDict["categoria"] as? NSString
                    productDatabase.productPower = productDict["potenciaMedia"] as? NSNumber
                    productDatabase.commit()
                }
            }
        }
            
        catch { print("Error to Save") }
    }
}

