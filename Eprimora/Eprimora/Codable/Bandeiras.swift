//
//  Bandeiras.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

struct Bandeiras: Codable {
    
    let cor: String?
    let descricao: String?
    let kwh: Int?
    let preco: String?
    let titulo: String?

    enum CodingKeys: String, CodingKey {

        case cor = "cor"
        case descricao = "descricao"
        case kwh = "kwh"
        case preco = "preco"
        case titulo = "titulo"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        cor = try values.decodeIfPresent(String.self, forKey: .cor)
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
        kwh = try values.decodeIfPresent(Int.self, forKey: .kwh)
        preco = try values.decodeIfPresent(String.self, forKey: .preco)
        titulo = try values.decodeIfPresent(String.self, forKey: .titulo)
    }
}
