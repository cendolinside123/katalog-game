//
//  GameDataRequest.swift
//  Game Catalog
//
//  Created by Mac on 25/10/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class GameDataRequestImp {
    init() {
        
    }
}

extension GameDataRequestImp: GameDataRequestProtocol {
    func getListGame(params: [String: String], result: @escaping ((JSON) -> Void), error: @escaping (() -> Void)) {
        AF.request(Constant.api, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                result(json)
                
            case.failure(let errorMessage):
                print("error getListGame: \(errorMessage)")
                error()
            }
        })
    }
    
    func getDetailGame(id: Int, params: [String: String], result: @escaping ((JSON) -> Void), error: @escaping (() -> Void)) {
        AF.request("\(Constant.api)/\(id)", method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                result(json)
                
            case.failure(let errorMessage):
                print("error getListGame: \(errorMessage)")
                error()
            }
        })
    }
    
    
}
