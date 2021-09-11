//
//  DetailMoviePresenter.swift
//  Game Catalog
//
//  Created by Mac on 10/09/21.
//

import Foundation
import UIKit

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
            
            DispatchQueue.main.async {
                superSelf.view?.getGameTitle().text = hasil.name
                superSelf.view?.getGameImage().setImage(url: hasil.backgroundImage)
                
                let filterText = hasil.description.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "</br>", with: "").replacingOccurrences(of: "<br />", with: "")
                
                superSelf.view?.getGameDescription().text = filterText
                
                if let view =  superSelf.view {
                    for ratingItem in hasil.ratings {
                        if ratingItem.id == 5 {
                            view.getExceptionalCountLabel().text = "\(ratingItem.count)"
                            view.getExceptionalPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(superSelf.calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getExceptionalPercenBar().bounds.height)))).isActive = true
                        } else if ratingItem.id == 4 {
                            view.getRecommendedCountLabel().text = "\(ratingItem.count)"
                            view.getRecommendedPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(superSelf.calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getRecommendedPercentBar().bounds.height)))).isActive = true
                        } else if ratingItem.id == 3 {
                            view.getMehCountLabel().text = "\(ratingItem.count)"
                            view.getMehPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(superSelf.calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getMehPercentBar().bounds.height)))).isActive = true
                        } else if ratingItem.id == 1 {
                            view.getSkipCountLabel().text = "\(ratingItem.count)"
                            view.getSkipPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(superSelf.calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getSkipPercentBar().bounds.height)))).isActive = true
                        }
                    }
                }
            }
            
        }, error: {
            
        })
    }
    
    func calculatePercentBar(percent: Double, heigh: Double) -> Double {
        self.view?.view.layoutIfNeeded()
        print("heigh: \(heigh)")
        let calculation = (percent * heigh) / 100
        print("calculation: \(calculation)")
        return calculation
    }
    
}
extension DetailMoviePresenter: DetailMoviePresenterRule {
    
}
