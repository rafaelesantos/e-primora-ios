//
//  VantagensCodable.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import Foundation

struct Vantagens: Codable {
    
    let descricao: String?
    let imagem: String?
    let titulo: String?

    enum CodingKeys: String, CodingKey {

        case descricao = "descricao"
        case imagem = "imagem"
        case titulo = "titulo"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
        imagem = try values.decodeIfPresent(String.self, forKey: .imagem)
        titulo = try values.decodeIfPresent(String.self, forKey: .titulo)
    }
}
