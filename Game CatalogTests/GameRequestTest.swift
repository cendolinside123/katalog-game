//
//  GameRequestTest.swift
//  Game CatalogTests
//
//  Created by Mac on 26/10/21.
//
import Alamofire
import SwiftyJSON
import XCTest
@testable import Game_Catalog

var requestController: GameDataRequestProtocol?

class GameRequestTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        requestController = GameDataRequestImp()
    }
    
    override func tearDown() {
        super.tearDown()
        requestController = nil
    }
    
    func testCallGameList() {
        let promise = expectation(description: "Response Success")
        
        requestController?.getListGame(params: ["key": Constant.key, "page_size": "10", "page": "\(1)" ], result: { json in
            if json["error"].string != nil && !json["results"].exists() && json["results"].array?.count == 10 {
                XCTFail("failed load result")
            } else {
                promise.fulfill()
            }
        }, error: {
            XCTFail("failed load result")
        })
        
        wait(for: [promise], timeout: 5)
    }
    
    func testCallGameDetail() {
        let promise = expectation(description: "Response Success")
        requestController?.getDetailGame(id: 3498, params: ["key": Constant.key], result: { json in
            if json["error"].string != nil {
                XCTFail("failed load game detail")
            } else {
                promise.fulfill()
            }
        }, error: {
            XCTFail("failed load game detail")
        })
        wait(for: [promise], timeout: 5)
    }
    
    func testFailedCallGameList() {
        let promise = expectation(description: "Response Failed")
        
        requestController?.getListGame(params: ["": ""], result: { json in
            if json["error"].string != nil {
                promise.fulfill()
            } else {
                XCTFail("response should't success")
            }
        }, error: {
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
    }
    
    func testFailedCallGameDetail() {
        let promise = expectation(description: "Response Failed")
        requestController?.getDetailGame(id: 1, params: ["": ""], result: { json in
            if json["error"].string != nil {
                promise.fulfill()
            } else {
                XCTFail("response should't success")
            }
        }, error: {
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
    }

}
