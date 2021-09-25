//
//  GameDataSources.swift
//  Game Catalog
//
//  Created by Mac on 24/09/21.
//

import Foundation
import CoreData

class GameDataSources {
    
}

extension GameDataSources: GameDataSourcesProtocol {
    func addAllGames(managedContext: NSManagedObjectContext, game: [Game], success: () -> Void, failed: () -> Void) {
        do {
            // note: di sini attribute coredata dari entity Games yang disimpan emang sengaja tidak mengikuti model Game, karena property pada model Game terlalu banyak dan tidak terlalu pentig untuk di simpan
            for dataGame in game {
                let aGame = Games(context: managedContext)
                aGame.id = Int64(dataGame.id)
                aGame.name = dataGame.name
                aGame.score = Int64(dataGame.rating)
                aGame.releaseDate = dataGame.released
                aGame.backgroundImage = dataGame.backgroundImage
                
                try managedContext.save()
            }
            
            success()
            
        } catch let error as NSError {
            print("Could not write \(error), \(error.userInfo)")
            failed()
        }
        
    }
    
    func getAllGame(managedContext: NSManagedObjectContext, success: ([Game]) -> Void, failed: () -> Void) {
        let fetchGame: NSFetchRequest<Games> = Games.fetchRequest()
        
        do {
            
            let getAllGame = try managedContext.fetch(fetchGame)
            
            var listGame = [Game]()
            
            for gameData in getAllGame {
//                let getRatings = gameData.rating?.allObjects as? [Ratings]
                var rating = [Rating]()
                if let getRatings = gameData.rating?.allObjects as? [Ratings] {
                    for ratingData in getRatings {
                        let aRating = Rating(id: Int(ratingData.id), title: ratingData.title ?? "", count: Double(ratingData.count), percent: ratingData.percent)
                        rating.append(aRating)
                    }
                }
                
                // note: di sini attribute coredata dari entity Games yang disimpan emang sengaja tidak mengikuti model Game, karena property pada model Game terlalu banyak dan tidak terlalu pentig untuk di simpan
                let game = Game(id: Int(gameData.id), slug: gameData.name ?? "", name: gameData.name ?? "", released: "\(gameData.releaseDate ?? "")", tba: false, backgroundImage: gameData.backgroundImage ?? "", rating: Double(gameData.score), ratingTop: 0, ratings: rating, ratingsCount: 0, reviewsTextCount: 0, added: 0, addedByStatus: AddedStatus(yet: 0, owned: 0, beaten: 0, toplay: 0, dropped: 0, playing: 0), metacritic: 0, playtime: 0, suggestionsCount: 0, updated: "", usergame: "", reviewsCount: 0, saturatedColor: "", dominantColor: "", platforms: [])
                listGame.append(game)
                
            }
            success(listGame)
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            failed()
        }
    }
    
    func getaGame(managedContext: NSManagedObjectContext, id: Int, success: (Game) -> Void, failed: () -> Void) {
        let fetchGame: NSFetchRequest<Games> = Games.fetchRequest()
        fetchGame.predicate = NSPredicate(format: "%K == %@", (\Games.id)._kvcKeyPathString!, String(id))
        do {
            
            guard let getaGame = try managedContext.fetch(fetchGame).first else {
                failed()
                return
            }
            
            var rating = [Rating]()
            
            if let getRatings = getaGame.rating?.allObjects as? [Ratings] {
                for ratingData in getRatings {
                    let aRating = Rating(id: Int(ratingData.id), title: ratingData.title ?? "", count: Double(ratingData.count), percent: ratingData.percent)
                    rating.append(aRating)
                }
            }
            
            // note: di sini attribute coredata dari entity Games yang disimpan emang sengaja tidak mengikuti model Game, karena property pada model Game terlalu banyak dan tidak terlalu pentig untuk di simpan
            let game = Game(id: Int(getaGame.id), slug: getaGame.name ?? "", name: getaGame.name ?? "", released: "\(getaGame.releaseDate ?? ""))", tba: false, backgroundImage: getaGame.backgroundImage ?? "", rating: Double(getaGame.score), ratingTop: 0, ratings: rating, ratingsCount: 0, reviewsTextCount: 0, added: 0, addedByStatus: AddedStatus(yet: 0, owned: 0, beaten: 0, toplay: 0, dropped: 0, playing: 0), metacritic: 0, playtime: 0, suggestionsCount: 0, updated: "", usergame: "", reviewsCount: 0, saturatedColor: "", dominantColor: "", platforms: [])
            success(game)
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            failed()
        }
    }
    
    func deleteAllGame(managedContext: NSManagedObjectContext, success: () -> Void, failed: () -> Void) {
        let fetchGame: NSFetchRequest<Games> = Games.fetchRequest()
        
        do {
            
            let getAllGames = try managedContext.fetch(fetchGame)
            
            for aGame in getAllGames {
                managedContext.delete(aGame)
            }
            
            try managedContext.save()
            success()
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            failed()
        }
    }
    
    func addaGame(managedContext: NSManagedObjectContext, game: Game, success: () -> Void, failed: () -> Void) {
        do {
            
            let aGame = Games(context: managedContext)
            aGame.id = Int64(game.id)
            aGame.name = game.name
            aGame.score = Int64(game.rating)
            aGame.releaseDate = game.released
            aGame.backgroundImage = game.backgroundImage
            
            try managedContext.save()
//            success()
            
            let fetchGame: NSFetchRequest<Games> = Games.fetchRequest()
            fetchGame.predicate = NSPredicate(format: "%K == %@", (\Games.id)._kvcKeyPathString!, String(game.id))
            
            if let getaGames = try managedContext.fetch(fetchGame).first, let editGame = getaGames.rating?.mutableCopy() as? NSMutableSet {
                
                for dataRating in game.ratings {
                    let ratings = Ratings(context: managedContext)
                    ratings.id = Int16(dataRating.id)
                    ratings.percent = dataRating.percent
                    ratings.count = dataRating.count
                    ratings.title = dataRating.title
                    ratings.game = getaGames
                    editGame.add(ratings)
                }
                
                try managedContext.save()
                success()
            } else {
                failed()
            }
            
            
        } catch let error as NSError {
            print("Could not write \(error), \(error.userInfo)")
            failed()
        }
    }
    
    func deleteaGame(managedContext: NSManagedObjectContext, id: Int, success: () -> Void, failed: () -> Void) {
        let fetchGame: NSFetchRequest<Games> = Games.fetchRequest()
        fetchGame.predicate = NSPredicate(format: "%K == %@", (\Games.id)._kvcKeyPathString!, String(id))
        do {
            
            if let getaGames = try managedContext.fetch(fetchGame).first {
                managedContext.delete(getaGames)
                try managedContext.save()
                success()
            } else {
                failed()
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            failed()
        }
    }
    
    func addAllGameRatings(managedContext: NSManagedObjectContext, game: [Game], success: () -> Void, failed: () -> Void) {
        let fetchGame: NSFetchRequest<Games> = Games.fetchRequest()
        
        do {
            
            let getAllGame = try managedContext.fetch(fetchGame)
            
            
            for gameData in getAllGame {
//                let getRatings = gameData.rating?.allObjects as? [Ratings]
                if let inputData = gameData.rating?.mutableCopy() as? NSMutableSet {
                    for aGame in game {
                        if Int(gameData.id) == aGame.id {
                            for dataRating in aGame.ratings {
                                let ratings = Ratings(context: managedContext)
                                ratings.id = Int16(dataRating.id)
                                ratings.percent = dataRating.percent
                                ratings.count = dataRating.count
                                ratings.title = dataRating.title
                                ratings.game = gameData
                                inputData.add(ratings)
                            }
                            try managedContext.save()
                        }
                    }
                } else {
                    failed()
                }
                
            }
            
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            failed()
        }
    }
    
}
