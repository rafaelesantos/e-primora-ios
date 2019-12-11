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
    let vantagens: [Vantagens]?

    enum CodingKeys: String, CodingKey {

        case descricao = "descricao"
        case vantagens = "vantagens"
    }

    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
        vantagens = try values.decodeIfPresent([Vantagens].self, forKey: .vantagens)
    }
}
