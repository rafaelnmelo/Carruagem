//
//  CarTemplate.swift
//  Carruagem
//
//  Created by Rafael Nunes on 12/08/20.
//  Copyright © 2020 Rafael Nunes. All rights reserved.
//

import UIKit

struct CarTemplate: Codable {
    let modelos: [CarModel]
}

struct CarModel: Codable {
    let nome: String
    let codigo: Int
}
