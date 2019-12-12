//
//  FirebasePaths.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import Firebase

public class FirebasePaths {
    
    static let sobreEprimora = Database.database().reference().child("sobreEprimora")
    static let classesDeConsumo = Database.database().reference().child("classesDeConsumo")
    static let bandeiraTarifarias = Database.database().reference().child("bandeiraTarifarias")
    static let eletrodomesticos = Database.database().reference().child("eletrodomesticos")
}
