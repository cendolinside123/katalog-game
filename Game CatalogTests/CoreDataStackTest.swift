//
//  CoreDataStackTest.swift
//  Game CatalogTests
//
//  Created by Mac on 28/10/21.
//

import Foundation
import CoreData
import XCTest
@testable import Game_Catalog

class CoreDataStackTest: CoreDataStack {
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            print("storeDescription: \(storeDescription)")
            if let getError = error as NSError? {
                print("Unresolved error \(getError), \(getError.userInfo)")
            }
        })

        self.setStroreContainer(container: container)
    }
}

var coreDataStack: CoreDataStackTest!
var gameDataSourceCoreData: GameDataSourcesProtocol!
class TestCoreData: XCTestCase {
    
//    override func setUp() {
//        super.setUp()
//        print("do setup")
//        coreDataStack = CoreDataStackTest(modelName: "GameCatalog")
//        gameDataSourceCoreData = GameDataSources()
//    }
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataStackTest(modelName: "GameCatalog")
        gameDataSourceCoreData = GameDataSources()
        
    }
    
    
    override func tearDown() {
        super.tearDown()
        print("do tearDown")
//        coreDataStack = nil
//        gameDataSourceCoreData = nil
    }
    
    func testInputFavorite() {
        
//        coreDataStack = CoreDataStackTest(modelName: "GameCatalog")
//        gameDataSourceCoreData = GameDataSources()
        
        print("context. notification \(coreDataStack.privateManagedContext)")
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.privateManagedContext, handler: { handler in
          print("handler: \(handler)")
          return true
        })

        coreDataStack.doInBackground(managedContext: { context in
            print("context.description: \(context.description)")
            print("context. :\(coreDataStack.privateManagedContext)")
            gameDataSourceCoreData.addaGame(managedContext: coreDataStack.privateManagedContext, game: Game(id: 1, slug: "grand-theft-auto-v", name: "Grand Theft Auto V", released: "2013-09-17", tba: false, backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", rating: 4.48, ratingTop: 5, ratings: [Rating(id: 5, title: "exceptional", count: 3077, percent: 59.14), Rating(id: 4, title: "recommended", count: 1712, percent: 32.9), Rating(id: 3, title: "meh", count: 328, percent: 6.3), Rating(id: 1, title: "skip", count: 86, percent: 1.65)], ratingsCount: 0, reviewsTextCount: 0, added: 0, addedByStatus: AddedStatus(yet: 0, owned: 0, beaten: 0, toplay: 0, dropped: 0, playing: 0), metacritic: 0, playtime: 0, suggestionsCount: 0, updated: "", usergame: "", reviewsCount: 0, saturatedColor: "", dominantColor: "", platforms: []), success: {
                coreDataStack.doInBackground(managedContext: { _ in
                    gameDataSourceCoreData.addGameRating(managedContext: coreDataStack.privateManagedContext, game: Game(id: 1, slug: "grand-theft-auto-v", name: "Grand Theft Auto V", released: "2013-09-17", tba: false, backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", rating: 4.48, ratingTop: 5, ratings: [Rating(id: 5, title: "exceptional", count: 3077, percent: 59.14), Rating(id: 4, title: "recommended", count: 1712, percent: 32.9), Rating(id: 3, title: "meh", count: 328, percent: 6.3), Rating(id: 1, title: "skip", count: 86, percent: 1.65)], ratingsCount: 0, reviewsTextCount: 0, added: 0, addedByStatus: AddedStatus(yet: 0, owned: 0, beaten: 0, toplay: 0, dropped: 0, playing: 0), metacritic: 0, playtime: 0, suggestionsCount: 0, updated: "", usergame: "", reviewsCount: 0, saturatedColor: "", dominantColor: "", platforms: []), success: {
                        XCTAssertTrue(true)
                    }, failed: {
                        XCTFail("error input rating")
                    })
                })
                
            }, failed: {
                XCTFail("error input")
            })
        })

        waitForExpectations(timeout: 2.0, handler: { error in
          XCTAssertNil(error, "Save did not occur")
        })

        
    }
    
    func testDeleteFavorite() {
        
//        coreDataStack = CoreDataStackTest(modelName: "GameCatalog")
//        gameDataSourceCoreData = GameDataSources()
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.privateManagedContext, handler: { handler in
          print("handler: \(handler)")
          return true
        })
        
        gameDataSourceCoreData.addaGame(managedContext: coreDataStack.managedContext, game: Game(id: 1, slug: "grand-theft-auto-v", name: "Grand Theft Auto V", released: "2013-09-17", tba: false, backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", rating: 4.48, ratingTop: 5, ratings: [Rating(id: 5, title: "exceptional", count: 3077, percent: 59.14), Rating(id: 4, title: "recommended", count: 1712, percent: 32.9), Rating(id: 3, title: "meh", count: 328, percent: 6.3), Rating(id: 1, title: "skip", count: 86, percent: 1.65)], ratingsCount: 0, reviewsTextCount: 0, added: 0, addedByStatus: AddedStatus(yet: 0, owned: 0, beaten: 0, toplay: 0, dropped: 0, playing: 0), metacritic: 0, playtime: 0, suggestionsCount: 0, updated: "", usergame: "", reviewsCount: 0, saturatedColor: "", dominantColor: "", platforms: []), success: {
            
            gameDataSourceCoreData.addGameRating(managedContext: coreDataStack.managedContext, game: Game(id: 1, slug: "grand-theft-auto-v", name: "Grand Theft Auto V", released: "2013-09-17", tba: false, backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", rating: 4.48, ratingTop: 5, ratings: [Rating(id: 5, title: "exceptional", count: 3077, percent: 59.14), Rating(id: 4, title: "recommended", count: 1712, percent: 32.9), Rating(id: 3, title: "meh", count: 328, percent: 6.3), Rating(id: 1, title: "skip", count: 86, percent: 1.65)], ratingsCount: 0, reviewsTextCount: 0, added: 0, addedByStatus: AddedStatus(yet: 0, owned: 0, beaten: 0, toplay: 0, dropped: 0, playing: 0), metacritic: 0, playtime: 0, suggestionsCount: 0, updated: "", usergame: "", reviewsCount: 0, saturatedColor: "", dominantColor: "", platforms: []), success: {
                
                coreDataStack.doInBackground(managedContext: { _ in
                    gameDataSourceCoreData.deleteaGame(managedContext: coreDataStack.privateManagedContext, id: 1, success: {
                        XCTAssertTrue(true)
                    }, failed: {
                        XCTFail("error delete data")
                    })
                })
                
            }, failed: {
                XCTFail("error input")
            })
            
            
            
        }, failed: {
            XCTFail("error input")
        })
        
        waitForExpectations(timeout: 2.0, handler: { error in
          XCTAssertNil(error, "Delete did not occur")
        })
        
    }
    
}
