//
//  GameDataSourcesProtocol.swift
//  Game Catalog
//
//  Created by Mac on 24/09/21.
//

import Foundation
import CoreData

protocol GameDataSourcesProtocol {
    func addAllGames(managedContext: NSManagedObjectContext, game: [Game], success: () -> Void, failed: () -> Void)
    func getAllGame(managedContext: NSManagedObjectContext, success: ([Game]) -> Void, failed: () -> Void)
    func getaGame(managedContext: NSManagedObjectContext, id: Int, success: (Game) -> Void, failed: () -> Void)
    func deleteAllGame(managedContext: NSManagedObjectContext, success: () -> Void, failed: () -> Void)
    func addaGame(managedContext: NSManagedObjectContext, game: Game, success: () -> Void, failed: () -> Void)
    func deleteaGame(managedContext: NSManagedObjectContext, game: Game, id: Int, success: () -> Void, failed: () -> Void)
    func addAllGameRatings(managedContext: NSManagedObjectContext, game: [Game], success: () -> Void, failed: () -> Void)
}
