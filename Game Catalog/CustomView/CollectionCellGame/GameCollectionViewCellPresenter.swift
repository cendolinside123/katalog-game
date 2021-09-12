//
//  GameCollectionViewCellPresenter.swift
//  Game Catalog
//
//  Created by Mac on 11/09/21.
//

import Foundation
import UIKit

class GameCollectionViewCellPresenter {
    
    private var view: GameCollectionViewCell?
    
    init(view: GameCollectionViewCell) {
        self.view = view
    }
}

extension GameCollectionViewCellPresenter: GameCollectionViewCellProtocol {
    func setupRatingValue(ratings: [Rating]) {
        guard let view = self.view else {
            return
        }
        view.layoutIfNeeded()
        for ratingItem in ratings {
            if ratingItem.id == 5 {
                view.getExceptionalCountLabel().text = "\(ratingItem.count)"
                view.getExceptionalPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getExceptionalPercenBar().bounds.width)))).isActive = true
            } else if ratingItem.id == 4 {
                view.getRecommendedCountLabel().text = "\(ratingItem.count)"
                view.getRecommendedPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getRecommendedPercentBar().bounds.width)))).isActive = true
            } else if ratingItem.id == 3 {
                view.getMehCountLabel().text = "\(ratingItem.count)"
                view.getMehPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getMehPercentBar().bounds.width)))).isActive = true
            } else if ratingItem.id == 1 {
                view.getSkipCountLabel().text = "\(ratingItem.count)"
                view.getSkipPercenFill().widthAnchor.constraint(equalToConstant: CGFloat(calculatePercentBar(percent: ratingItem.percent, heigh: Double(view.getSkipPercentBar().bounds.width)))).isActive = true
            }
        }
    }
}

extension GameCollectionViewCellPresenter {
    func calculatePercentBar(percent: Double, heigh: Double) -> Double {
        self.view?.layoutIfNeeded()
        print("heigh: \(heigh)")
        let calculation = (percent * heigh) / 100
        print("calculation: \(calculation)")
        return calculation
    }
}
