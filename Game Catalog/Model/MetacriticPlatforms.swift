//
//  MetacriticPlatforms.swift
//  Game Catalog
//
//  Created by Mac on 09/09/21.
//

import Foundation

struct MetacricsPlatform {
    let platform: Int
    let slug: String
    let name: String
}

struct MetacriticPlatforms {
    let metascore: Int
    let url: String
    let platform: MetacricsPlatform
    
}
