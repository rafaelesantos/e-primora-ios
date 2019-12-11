//
//  CategoriasClasses.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

struct CategoriasClasses: Codable {
    
    let descricao: String?
    let id: Int?
    let valor: String?

    enum CodingKeys: String, CodingKey {

        case descricao = "descricao"
        case id = "id"
        case valor = "valor"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        valor = try values.decodeIfPresent(String.self, forKey: .valor)
    }
}

