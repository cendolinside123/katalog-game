//
//  GameDataSourceImp.swift
//  Game Catalog
//
//  Created by Mac on 04/09/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class GameDataSourceImp {
    
    private let gameDataRequest: GameDataRequestProtocol
    
    init() {
        gameDataRequest = GameDataRequestImp()
    }
    
}

extension GameDataSourceImp: GameDataSourceProtocol {
    func getListGame(page: Int, result: @escaping (([Game]) -> Void), error: @escaping (() -> Void)) {
        
//        var params = Parameters()
//        params.updateValue(Constant.key, forKey: "key")
        
        let params: [String: String] = ["key": Constant.key, "page_size": "10", "page": "\(page)" ]
        
        gameDataRequest.getListGame(params: params, result: { json in
            
            var listGame = [Game]()
            
            for(_, subJson):(String, JSON) in json["results"] {
                listGame.append(Game(json: subJson))
            }
            result(listGame)
        }, error: {
            
        })
        
    }
    
    func getDetailGame(id: Int, result: @escaping ((GameDetail) -> Void), error: @escaping (() -> Void)) {
        let params: [String: String] = ["key": Constant.key]
        
        gameDataRequest.getDetailGame(id: id, params: params, result: { json in
            result(GameDetail(json: json))
        }, error: {
            error()
        })
        
    }
    
    
}
