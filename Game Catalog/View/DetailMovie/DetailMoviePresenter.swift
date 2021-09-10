//
//  DetailMoviePresenter.swift
//  Game Catalog
//
//  Created by Mac on 10/09/21.
//

import Foundation


class DetailMoviePresenter {
    
    var view: DetailMovieViewController?
    var gameDataSource: GameDataSourceProtocol?
    
    init(view: DetailMovieViewController) {
        self.view = view
        self.gameDataSource = GameDataSourceImp()
        loadDetail()
    }
    
}
extension DetailMoviePresenter {
    private func loadDetail() {
        guard let idGame = self.view?.getIdGame() else {
            return
        }
        gameDataSource?.getDetailGame(id: idGame, result: { [weak self] hasil in
            guard let superSelf = self else {
                return
            }
            
            superSelf.view?.getGameTitle().text = hasil.name
            superSelf.view?.getGameImage().setImage(url: hasil.backgroundImage)
            
            let filterText = hasil.description.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "</br>", with: "").replacingOccurrences(of: "<br />", with: "")
            
            superSelf.view?.getGameDescription().text = filterText
            
        }, error: {
            
        })
    }
}
extension DetailMoviePresenter: DetailMoviePresenterRule {
    
}
