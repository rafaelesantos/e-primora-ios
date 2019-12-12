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
        
        self.sobreEprimora.keepSynced(true)
        
        NetworkManager.isReachable { (_) in
            
            self.sobreEprimora.observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode(SobreEprimoraCodable.self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
        
        NetworkManager.isUnreachable { (_) in
            
            self.sobreEprimora.queryOrderedByKey().observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode(SobreEprimoraCodable.self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
    }
    
    public static func classesDeConsumo(completionHandler: @escaping (ClassesDeConsumoCodable) -> ()) {
        
        self.classesDeConsumo.keepSynced(true)
        
        NetworkManager.isReachable { (_) in
            
            self.classesDeConsumo.observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode(ClassesDeConsumoCodable.self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
        
        NetworkManager.isUnreachable { (_) in
            
            self.classesDeConsumo.queryOrderedByKey().observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode(ClassesDeConsumoCodable.self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
    }
    
    public static func bandeiraTarifarias(completionHandler: @escaping (BandeirasTarifariasCodable) -> ()) {
        
        self.bandeiraTarifarias.keepSynced(true)
        
        NetworkManager.isReachable { (_) in
            
            self.bandeiraTarifarias.observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode(BandeirasTarifariasCodable.self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
        
        NetworkManager.isUnreachable { (_) in
            
            self.bandeiraTarifarias.queryOrderedByKey().observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode(BandeirasTarifariasCodable.self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
    }
    
    public static func eletrodomesticos(completionHandler: @escaping ([EletrodomesticoCodable]) -> ()) {
        
        self.eletrodomesticos.keepSynced(true)
        
        NetworkManager.isReachable { (_) in
            
            self.eletrodomesticos.observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode([EletrodomesticoCodable].self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
        
        NetworkManager.isUnreachable { (_) in
            
            self.eletrodomesticos.queryOrderedByKey().observe(.value) { (values) in
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: values.value ?? [], options: .prettyPrinted)
                    let codable = try JSONDecoder().decode([EletrodomesticoCodable].self, from: data)
                    DispatchQueue.main.async { completionHandler(codable) }
                }
                
                catch { print(error.localizedDescription) }
            }
        }
    }
}
