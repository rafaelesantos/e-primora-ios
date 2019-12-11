//
//  BandeirasTarifariasCodable.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public struct BandeirasTarifariasCodable: Codable {
    
    let bandeiras: [Bandeiras]?
    let descricao: String?

    enum CodingKeys: String, CodingKey {

        case bandeiras = "bandeiras"
        case descricao = "descricao"
    }

    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        bandeiras = try values.decodeIfPresent([Bandeiras].self, forKey: .bandeiras)
        descricao = try values.decodeIfPresent(String.self, forKey: .descricao)
    }
}
