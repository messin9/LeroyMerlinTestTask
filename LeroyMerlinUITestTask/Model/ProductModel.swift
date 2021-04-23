//
//  ProductModel.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 16.04.2021.
//

import Foundation

struct ProductModel: Decodable {
    let name: String?
    let price: Double?
    var units: String? = " ₽/шт."
}
