//
//  GameDataRequestProtocol.swift
//  Game Catalog
//
//  Created by Mac on 25/10/21.
//

import Foundation
import SwiftyJSON

protocol GameDataRequestProtocol {
    func getListGame(params: [String: String], result: @escaping ((JSON) -> Void), error: @escaping (() -> Void))
    func getDetailGame(id: Int, params: [String: String], result: @escaping ((JSON) -> Void), error: @escaping (() -> Void))
}
