//
//  GameDataSource.swift
//  Game CatalogTests
//
//  Created by Mac on 21/10/21.
//

import XCTest
@testable import Game_Catalog

var gameDataSource: GameDataSourceProtocol?

class GameDataSource: XCTestCase {

    override func setUp() {
        super.setUp()
        gameDataSource = GameDataSourceImp()
    }
    
    override func tearDown() {
        super.tearDown()
        gameDataSource = nil
    }
    
    func testGetGameList() {
        
        let promise = expectation(description: "Response Success")
        
        gameDataSource?.getListGame(page: 1, result: { listGame in
            if listGame.count != 0 && listGame.count == 10 {
                promise.fulfill()
            } else {
                XCTFail("not fullfil the condition")
            }
        }, error: {
            XCTFail("error get list of games")
        })
        wait(for: [promise], timeout: 5)
    }
    
    func testGetGameDetail() {
        
        let promise = expectation(description: "Response Success")
        
        gameDataSource?.getDetailGame(id: 3498, result: { gameDetail in
            if gameDetail.id == 3498 {
                promise.fulfill()
            } else {
                XCTFail("data not same")
            }
        }, error: {
            XCTFail("error get detail of game")
        })
        wait(for: [promise], timeout: 5)
    }
    
//    func testFailedGetGameList() {
//        
//    }
//    
//    func testFailedGetGameDetail() {
//        
//    }

}
