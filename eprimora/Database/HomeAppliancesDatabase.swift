//
//  HomeAppliancesDatabase.swift
//  eprimora
//
//  Created by Rafael Escaleira on 23/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import Foundation
import SharkORM

public class HomeAppliancesDatabase: SRKObject {
    
    @objc dynamic var productID: NSNumber?
    @objc dynamic var productName: NSString?
    @objc dynamic var productCategories: NSString?
    @objc dynamic var productPower: NSNumber?
}
