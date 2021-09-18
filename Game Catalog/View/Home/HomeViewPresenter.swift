//
//  HomeViewPresenter.swift
//  Game Catalog
//
//  Created by Mac on 06/09/21.
//

import Foundation
import UIKit

class HomeViewPresenter: NSObject {
    
    private var view: HomeViewController?
    private var listGame = [Game]()
    private var gameDataSource: GameDataSourceProtocol?
    private var page: Int = 1
    private var updateScroll = true
    private var doUpdate: Bool = true {
        didSet {
            if oldValue == true && doUpdate == true {
                doUpdate = false
                print("scroll task something wrong, set it to false")
            } else {
                print("scroll task vertified")
            }
        }
    }
    
    override init() {
        super.init()
        
    }
    
    convenience init(view: HomeViewController) {
        self.init()
        self.view = view
        gameDataSource = GameDataSourceImp()
        self.view?.getCollectionView().delegate = self
        self.view?.getCollectionView().dataSource = self
        self.view?.getCollectionView().register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "gameCell")
        self.view?.getCollectionView().register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        
//        self.view?.getScrollView().delegate = self
        self.view?.showLoadingNotifNoAnimation()
        loadData()
    }
    
}

extension HomeViewPresenter: HomeViewPresenterRule {
    private func loadData() {
        DispatchQueue.global().async { [weak self] in
            guard let superSelf = self else {
                return
            }
            superSelf.gameDataSource?.getListGame(page: superSelf.page, result: { listOfGame in
                DispatchQueue.main.async {
                    let oldPage = superSelf.listGame.count
                    superSelf.listGame += listOfGame
                    
                    if listOfGame.count != 0 {
                        
                        var indexPath = [IndexPath]()
                        
                        for index in oldPage ... superSelf.listGame.count - 1 {
                            print("i: \(index)")
                            indexPath.append(IndexPath(item: index, section: 0))
                        }
                        
                        superSelf.view?.getCollectionView().insertItems(at: indexPath)
                        
                        if let getNumberData = superSelf.view?.getCollectionView().numberOfItems(inSection: 0), getNumberData >= 50 {
                            print("data sudah kebanyakan: \(getNumberData)")
                            
                            var delIndexPath = [IndexPath]()
                            
                            for index in 0 ... 21 {
                                print("data i: \(index)")
                                delIndexPath.append(IndexPath(item: index, section: 0))
                                superSelf.listGame.remove(at: index)
                            }
                            superSelf.view?.getCollectionView().deleteItems(at: delIndexPath)
                            print("data saat ini: \(superSelf.view?.getCollectionView().numberOfItems(inSection: 0))")
                        }
                        
                        if superSelf.page != 1 {
                            superSelf.doUpdate = true
                        } else {
                            
                        }
                        // superSelf.view?.updateContainerHeighConstraint()
                        
                        superSelf.page += 1
                        superSelf.view?.hideLoadingNofif()
                    }
                }
                
            }, error: {
                superSelf.doUpdate = true
            })
        }
    }
}

extension HomeViewPresenter: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }
        
        let item = listGame[indexPath.row]
        cell.setupData(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCollectionViewCell  else {
            return
        }
        
        cell.returnGameImage().kf.cancelDownloadTask()
        cell.returnGameImage().image = #imageLiteral(resourceName: "game")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailMovieViewController()
        detail.setIdGame(idGame: listGame[indexPath.item].id)
        detail.modalPresentationStyle = .overFullScreen
        self.view?.present(detail, animated: true, completion: nil)
    }
    
}

extension HomeViewPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemPerRow = 2
        let spacing = 10
        
        let totalSpacing = (2 * 10) + ((numberOfItemPerRow - 1) * spacing)
        
        let width = (Int(collectionView.bounds.width) - totalSpacing)/numberOfItemPerRow
        return CGSize(width: width, height: width + 100)
    }
}

extension HomeViewPresenter: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("scrollView.contentOffset.y: \(scrollView.contentOffset.y) , scrollView.frame.size.height: \(scrollView.frame.size.height), scrollView.contentSize.height: \(scrollView.contentSize.height)")
        
        let titleHeigh = self.view?.getTitle().frame.height ?? 0
        view?.getCollectionView().layoutIfNeeded()
        if self.updateScroll && scrollView.contentOffset.y != 0 {
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.view?.getTitle().alpha = 0
                self.view?.increaseContainerHeight()
                self.view?.updateCollectionHeighConstraint()
                self.view?.getContainer().frame.origin.y = -titleHeigh
                self.view?.view.layoutIfNeeded()
            }, completion: nil)
            
            
        } else {
            
        }
        
        if scrollView.contentOffset.y == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view?.getTitle().alpha = 1
                self.view?.decreaseContainerHeight()
                self.view?.updateCollectionHeighConstraint()
                self.view?.getContainer().frame.origin.y = 0
                self.view?.view.layoutIfNeeded()
            }, completion: {_ in
                self.updateScroll = true
            })
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if (scrollView as? UICollectionView) != nil {
            let scrollViewHeight = scrollView.frame.size.height
            let scrollContentSizeHeight = scrollView.contentSize.height
            let scrollOffset = scrollView.contentOffset.y
            
            if (scrollOffset + scrollViewHeight == scrollContentSizeHeight) && doUpdate == true {
                
                doUpdate = false
                
                self.view?.showLoadingNotif()
                
                print("scrollViewDidEndDecelerating true")
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                    self?.loadData()
                })
            } else {
                print("scrollViewDidEndDecelerating false")
            }
        }
        
    }
}
