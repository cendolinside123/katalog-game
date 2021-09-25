//
//  FavoriteViewPresenter.swift
//  Game Catalog
//
//  Created by Mac on 25/09/21.
//

import Foundation
import UIKit

class FavoriteViewPresenter: NSObject {
    
    private var view: FavoriteViewController?
    private var listGame = [Game]()
    private var gameDataSource: GameDataSourceProtocol?
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
    private var gameDataSourceCoreData: GameDataSourcesProtocol?
    
    override init() {
        super.init()
        
    }
    
    convenience init(view: FavoriteViewController) {
        self.init()
        self.view = view
        gameDataSourceCoreData = GameDataSources()
        self.view?.getCollectionView().delegate = self
        self.view?.getCollectionView().dataSource = self
        self.view?.getCollectionView().register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "gameCell")
        self.view?.getCollectionView().register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        
        let logPresReco: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        logPresReco.minimumPressDuration = 0.5
        logPresReco.delegate = self
        logPresReco.delaysTouchesBegan = true
        self.view?.getCollectionView().addGestureRecognizer(logPresReco)
        self.view?.showLoadingNotifNoAnimation()
        loadData()
    }
    
}

extension FavoriteViewPresenter: FavoriteViewPresenterRule {
    
}

extension FavoriteViewPresenter {
    private func loadData() {
        self.view?.getCoreDataStack()?.doInBackground(managedContext: { [weak self] context in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.gameDataSourceCoreData?.getAllGame(managedContext: context, success: { result in
                DispatchQueue.main.async {
                    strongSelf.listGame = result
                    strongSelf.view?.getCollectionView().reloadData()
                    strongSelf.view?.hideLoadingNofif()
                    strongSelf.view?.view.layoutIfNeeded()
                }
                
            }, failed: {
                strongSelf.view?.hideLoadingNofif()
            })
            
        })
    }
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {

        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }

        let point = gestureRecognizer.location(in: self.view?.getCollectionView())

        if let indexPath = (self.view?.getCollectionView().indexPathForItem(at: point)) {
            let alert = UIAlertController(title: "Delete from favorite", message: "Do you want delete \(listGame[indexPath.item].name) from your favorite list", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
                
                guard let strongSelf = self else {
                    return
                }
                strongSelf.view?.getCoreDataStack()?.doInBackground(managedContext: { context in
                    
                    strongSelf.gameDataSourceCoreData?.deleteaGame(managedContext: context, id: strongSelf.listGame[indexPath.item].id, success: {
                        strongSelf.loadData()
                    }, failed: {
                        print("delete failed")
                    })
                })
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
                
            }))
            self.view?.present(alert, animated: true)
            print("name: \(listGame[indexPath.item].name)")
            
        }

    }
}

extension FavoriteViewPresenter: UICollectionViewDelegate, UICollectionViewDataSource {
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
extension FavoriteViewPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemPerRow = 2
        let spacing = 10
        
        let totalSpacing = (2 * 10) + ((numberOfItemPerRow - 1) * spacing)
        
        let width = (Int(collectionView.bounds.width) - totalSpacing)/numberOfItemPerRow
        return CGSize(width: width, height: width + 100)
    }
}
extension FavoriteViewPresenter: UIScrollViewDelegate {
    
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
        
    }
}
extension FavoriteViewPresenter: UIGestureRecognizerDelegate {
    
}
