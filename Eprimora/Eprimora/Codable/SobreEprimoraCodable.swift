//
//  PresentationCodable.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import Foundation

public struct SobreEprimoraCodable: Codable {
    
    let descricao: String?
    let vantagens: [VantagensCodable]?

    enum CodingKeys: String, CodingKey {

        case descricao = "descricao"
        case vantagens = "vantagens"
    }

    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
        vantagens = try values.decodeIfPresent([VantagensCodable].self, forKey: .vantagens)
    }
}

struct VantagensCodable: Codable {
    
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
