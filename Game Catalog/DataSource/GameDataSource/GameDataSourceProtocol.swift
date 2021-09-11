//
//  GameDataSourceProtocol.swift
//  Game Catalog
//
//  Created by Mac on 04/09/21.
//

import Foundation

protocol GameDataSourceProtocol {
    func getListGame(page: Int, result: @escaping (([Game]) -> Void), error: @escaping (() -> Void))
    func getDetailGame(id: Int, result: @escaping ((GameDetail) -> Void), error: @escaping (() -> Void))
}
