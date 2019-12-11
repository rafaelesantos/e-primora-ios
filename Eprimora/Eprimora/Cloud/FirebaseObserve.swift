//
//  FirebaseObserve.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public class FirebaseObserve: FirebasePaths {
    
    public static func sobreEprimora(completionHandler: @escaping (SobreEprimoraCodable) -> ()) {
        
        self.sobreEprimora.observe(.value) { (values) in
            
            do {
                
                let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                let codable = try JSONDecoder().decode(SobreEprimoraCodable.self, from: data)
                DispatchQueue.main.async { completionHandler(codable) }
            }
            
            catch { print(error.localizedDescription) }
        }
    }
    
    public static func classesDeConsumo(completionHandler: @escaping (ClassesDeConsumoCodable) -> ()) {
        
        self.classesDeConsumo.observe(.value) { (values) in
            
            do {
                
                let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                let codable = try JSONDecoder().decode(ClassesDeConsumoCodable.self, from: data)
                DispatchQueue.main.async { completionHandler(codable) }
            }
            
            catch { print(error.localizedDescription) }
        }
    }
    
    public static func bandeiraTarifarias(completionHandler: @escaping (BandeirasTarifariasCodable) -> ()) {
        
        self.bandeiraTarifarias.observe(.value) { (values) in
            
            do {
                
                let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                let codable = try JSONDecoder().decode(BandeirasTarifariasCodable.self, from: data)
                DispatchQueue.main.async { completionHandler(codable) }
            }
            
            catch { print(error.localizedDescription) }
        }
    }
}
