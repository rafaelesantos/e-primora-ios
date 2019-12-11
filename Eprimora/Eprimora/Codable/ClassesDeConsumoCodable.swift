//
//  ClassesDeConsumoCodable.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public struct ClassesDeConsumoCodable: Codable {
    
    let categoriasClasses: [CategoriasClasses]?
    let descricao: String?

    enum CodingKeys: String, CodingKey {

        case categoriasClasses = "categoriasClasses"
        case descricao = "descricao"
    }

    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        categoriasClasses = try values.decodeIfPresent([CategoriasClasses].self, forKey: .categoriasClasses)
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
    }
}
