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
    
    init() {
        
    }
    
}

extension GameDataSourceImp: GameDataSourceProtocol {
    func getListGame(page: Int, result: @escaping (([Game]) -> Void), error: @escaping (() -> Void)) {
        
//        var params = Parameters()
//        params.updateValue(Constant.key, forKey: "key")
        
        let params: [String: String] = ["key": Constant.key, "page_size": "10", "page": "\(page)" ]
        
        AF.request(Constant.api, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                var listGame = [Game]()
                
                for(_, subJson):(String, JSON) in json["results"] {
                    listGame.append(Game(json: subJson))
                }
                result(listGame)
                
            case.failure(let errorMessage):
                print("error getListGame: \(errorMessage)")
                error()
            }
            
        })
        
    }
    
    func getDetailGame(id: Int, result: @escaping ((GameDetail)-> Void), error: @escaping (() -> Void)) {
        let params: [String: String] = ["key": Constant.key]
        
        AF.request("\(Constant.api)/\(id)", method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                result(GameDetail(json: json))
                
            case.failure(let errorMessage):
                print("error getListGame: \(errorMessage)")
                error()
            }
            
        })
        
    }
    
    
}
