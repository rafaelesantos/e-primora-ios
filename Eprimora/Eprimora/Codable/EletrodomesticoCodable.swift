//
//  EletrodomesticoCodable.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

public struct EletrodomesticoCodable: Codable {
    
    var categorias: [Int]?
    var imagem: String?
    var marcas: [MarcasCodable]?
    var nome: String?
    
    var estaSelecionado: Bool = false
    var categoriaSelecionada: Int = 0
    
    var diasDeUso: Int = Int.random(in: 1 ... 30)
    var tempoDeUso: Int = Int.random(in: 1 ... 24)
    var quantidade: Int = Int.random(in: 1 ... 6)
    var marcaSelecionada: String = "Selecione uma marca"
    var potenciaSelecionada: Int = 0
    var totalConsumoDiario: Double = 0
    var totalConsumoMensal: Double = 0
    
    enum CodingKeys: String, CodingKey {
        
        case categorias = "categorias"
        case imagem = "imagem"
        case marcas = "marcas"
        case nome = "nome"
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        categorias = try values.decodeIfPresent([Int].self, forKey: .categorias)
        imagem = try values.decodeIfPresent(String.self, forKey: .imagem)
        marcas = try values.decodeIfPresent([MarcasCodable].self, forKey: .marcas)
        nome = try values.decodeIfPresent(String.self, forKey: .nome)
    }
}

struct MarcasCodable: Codable {
    
    let nome: String?

    enum CodingKeys: String, CodingKey {

        case nome = "nome"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        nome = try values.decodeIfPresent(String.self, forKey: .nome)
    }
}
