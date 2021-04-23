//
//  SectionModel.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 16.04.2021.
//

import Foundation

struct SectionModel: Decodable {
    let type: String?
    let title: String?
    let items: [ProductModel]?
}
