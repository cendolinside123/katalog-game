//
//  Game.swift
//  Game Catalog
//
//  Created by Mac on 03/09/21.
//

import Foundation
import SwiftyJSON

struct Game {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Double
    let ratings: [Rating]
    let ratingsCount: Double
    let reviewsTextCount: Double
    let added: Int
    let addedByStatus: AddedStatus
    let metacritic: Int
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
    let usergame: String?
    let reviewsCount: Double
    let saturatedColor: String
    let dominantColor: String
    let platforms: [Platforms]
    
    init(id: Int ,slug: String ,name: String ,released: String ,tba: Bool ,backgroundImage: String ,rating: Double ,ratingTop: Double ,ratings: [Rating] ,ratingsCount: Double ,reviewsTextCount: Double ,added: Int ,addedByStatus: AddedStatus ,metacritic: Int ,playtime: Int ,suggestionsCount: Int ,updated: String ,usergame: String? ,reviewsCount: Double ,saturatedColor: String ,dominantColor: String ,platforms: [Platforms]) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.tba = tba
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.ratings = ratings
        self.ratingsCount = ratingsCount
        self.reviewsTextCount = reviewsTextCount
        self.added = added
        self.addedByStatus = addedByStatus
        self.metacritic = metacritic
        self.playtime = playtime
        self.suggestionsCount = suggestionsCount
        self.updated = updated
        self.usergame = usergame
        self.reviewsCount = reviewsCount
        self.saturatedColor = saturatedColor
        self.dominantColor = dominantColor
        self.platforms = platforms
    }
    
    init(json: JSON) {
        
        var ratings = [Rating]()
        for(_, subJson):(String, JSON) in json["ratings"] {
            ratings.append(Rating(id: subJson["id"].intValue, title: subJson["title"].stringValue, count: subJson["count"].doubleValue, percent: subJson["percent"].doubleValue))
        }
        
        let addedByStatus = AddedStatus(yet: json["added_by_status"]["yet"].doubleValue, owned: json["added_by_status"]["owned"].doubleValue, beaten: json["added_by_status"]["beaten"].doubleValue, toplay: json["added_by_status"]["toplay"].doubleValue, dropped: json["added_by_status"]["dropped"].doubleValue, playing: json["added_by_status"]["playing"].doubleValue)
        
        var platforms = [Platforms]()
        for(_, subJson):(String, JSON) in json["platforms"] {
            let platform = Platform(id: subJson["id"].int64Value, name: subJson["name"].stringValue, slug: subJson["slug"].stringValue, image: subJson["image"].string, yearEnd: subJson["year_end"].int, yearStart: subJson["year_start"].intValue, gamesCount: subJson["games_count"].int64Value, imageBackground: subJson["image_background"].stringValue)
            platforms.append(Platforms(platform: platform, releasedAt: subJson["released_at"].stringValue, requirementsEn: subJson["requirements_en"].stringValue, requirementsRu: subJson["requirements_ru"].stringValue))
        }
        
        self.init(id: json["id"].intValue, slug: json["slug"].stringValue, name: json["name"].stringValue, released: json["released"].stringValue, tba: json["tba"].boolValue, backgroundImage: json["background_image"].stringValue, rating: json["rating"].doubleValue, ratingTop: json["rating_top"].doubleValue, ratings: ratings, ratingsCount: json["ratings_count"].doubleValue, reviewsTextCount: json["reviews_text_count"].doubleValue, added: json["added"].intValue, addedByStatus: addedByStatus, metacritic: json["metacritic"].intValue, playtime: json["playtime"].intValue, suggestionsCount: json["suggestions_count"].intValue, updated: json["updated"].stringValue, usergame: json["user_game"].string, reviewsCount: json["reviews_count"].doubleValue, saturatedColor: json["saturated_color"].stringValue, dominantColor: json["dominant_color"].stringValue, platforms: platforms)
    }
    
}
