//
//  GameDetail.swift
//  Game Catalog
//
//  Created by Mac on 09/09/21.
//

import Foundation
import SwiftyJSON

struct GameDetail {
    let id: Int
    let slug: String
    let name: String
    let nameOriginal: String
    let description: String
    let metacritic: Int
    let metacriticPlatforms: [MetacriticPlatforms]
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage: String
    let backgroundImageAdiditional: String
    let website: String
    let rating: Double
    let ratingTop: Double
    let ratings: [Rating]
    let ratingsCount: Double
    init(id: Int, slug: String, name: String, nameOriginal: String, description: String, metacritic: Int, metacriticPlatforms: [MetacriticPlatforms], released: String, tba: Bool, updated: String, backgroundImage: String, backgroundImageAdiditional: String, website: String, rating: Double, ratingTop: Double, ratings: [Rating], ratingsCount: Double) {
        self.id = id
        self.slug = slug
        self.name = name
        self.nameOriginal = nameOriginal
        self.description = description
        self.metacritic = metacritic
        self.metacriticPlatforms = metacriticPlatforms
        self.released = released
        self.tba = tba
        self.updated = updated
        self.backgroundImage = backgroundImage
        self.backgroundImageAdiditional = backgroundImageAdiditional
        self.website = website
        self.rating = rating
        self.ratingTop = ratingTop
        self.ratings = ratings
        self.ratingsCount = ratingsCount
    }
    
    init(json: JSON) {
        var ratings = [Rating]()
        for(_, subJson):(String, JSON) in json["ratings"] {
            ratings.append(Rating(id: subJson["id"].intValue, title: subJson["title"].stringValue, count: subJson["count"].doubleValue, percent: subJson["percent"].doubleValue))
        }
        
        var metacriticPlatforms = [MetacriticPlatforms]()
        for(_, subJson):(String, JSON) in json["metacritic_platforms"] {
            let platformMeta = MetacricsPlatform(platform: subJson["platform"]["platform"].intValue, slug: subJson["platform"]["name"].stringValue, name: subJson["platform"]["slug"].stringValue)
            metacriticPlatforms.append(MetacriticPlatforms(metascore: subJson["platform"]["metascore"].intValue, url: subJson["platform"]["url"].stringValue, platform: platformMeta))
        }
        
        self.init(id: json["id"].intValue, slug: json["slug"].stringValue, name: json["name"].stringValue, nameOriginal: json["name_original"].stringValue, description: json["description"].stringValue, metacritic: json["metacritic"].intValue, metacriticPlatforms: metacriticPlatforms, released: json["released"].stringValue, tba: json["tba"].boolValue, updated: json["updated"].stringValue, backgroundImage: json["background_image"].stringValue, backgroundImageAdiditional: json["background_image_additional"].stringValue, website: json["website"].stringValue, rating: json["rating"].doubleValue, ratingTop: json["rating_top"].doubleValue, ratings: ratings, ratingsCount: json["ratings_count"].doubleValue)
        
    }
    
}

