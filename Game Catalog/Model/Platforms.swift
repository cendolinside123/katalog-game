//
//  Platforms.swift
//  Game Catalog
//
//  Created by Mac on 04/09/21.
//

import Foundation

struct Platform {
    let id: Int64
    let name: String
    let slug: String
    let image: String?
    let yearEnd: Int?
    let yearStart: Int
    let gamesCount: Int64
    let imageBackground: String
}

struct Platforms {
    let platform: Platform
    let releasedAt: String
    let requirementsEn: String
    let requirementsRu: String
}
