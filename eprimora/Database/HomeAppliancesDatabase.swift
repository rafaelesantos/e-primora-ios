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
    @objc dynamic var productConvenient: NSString?
    @objc dynamic var productPower: NSNumber?
    @objc dynamic var productImage: NSData?
    @objc dynamic var productMinPower: NSNumber?
    @objc dynamic var productMaxPower: NSNumber?
}
