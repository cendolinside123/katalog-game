//
//  DetailMovieViewController.swift
//  Game Catalog
//
//  Created by Mac on 03/09/21.
//

import UIKit

class DetailMovieViewController: UIViewController {

    private let tabBar = CustomTabBar()
    private let gameTitle = UILabel()
    private let gameImage = UIImageView()
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.layoutMargins.left = 10
        stack.layoutMargins.right = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let gameDescription = UILabel()
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private var idGame: Int = 0
    private var presenter: DetailMoviePresenterRule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayout()
        addConstraint()
        
        tabBar.isRightButtonHidden = true
        tabBar.setLeftButtonText(text: "X")
        tabBar.leftButtonAction = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        presenter = DetailMoviePresenter(view: self)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func addLayout() {
        addTabBar()
        addScrollView()
        addContainerView()
        addGameTitle()
        addGameImage()
        addGameDescription()
        
        addContentStackView()
    }
    
    private func addConstraint() {
        let views = ["tabBar": tabBar, "scrollView": scrollView, "contentStackView": contentStackView, "gameTitle": gameTitle, "gameImage": gameImage, "gameDescription": gameDescription, "containerView": containerView]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let hScrollView = "H:|-0-[scrollView]-0-|"
        let hTabBar = "H:|-0-[tabBar]-0-|"
        let vScrollView = "V:|-0-[tabBar]-0-[scrollView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hScrollView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTabBar, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vScrollView, options: .alignAllLeading, metrics: metrix, views: views)
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let hContainerView = "H:|-0-[containerView]-0-|"
        let vContainerView = "V:|-0-[containerView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContainerView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContainerView, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)]
        //constraints += [NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)]
        
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let hStackView = "H:|-0-[contentStackView]-0-|"
        let vStackView = "V:|-0-[contentStackView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackView, options: .alignAllLeft, metrics: metrix, views: views)
        
        
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: gameTitle, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0)]
        
        
        gameImage.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: gameImage, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 4/10, constant: 0)]
        
        
        gameDescription.translatesAutoresizingMaskIntoConstraints = false
//        constraints += [NSLayoutConstraint(item: gameDescription, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 8/10, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addTabBar() {
        view.addSubview(tabBar)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
    }
    
    private func addContainerView() {
        scrollView.addSubview(containerView)
        containerView.backgroundColor = .white
    }
    
    private func addContentStackView() {
        containerView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(gameTitle)
        contentStackView.addArrangedSubview(gameImage)
        contentStackView.addArrangedSubview(gameDescription)
    }
    
    private func addGameTitle() {
        containerView.addSubview(gameTitle)
        gameTitle.font = UIFont.boldSystemFont(ofSize: 25)
        gameTitle.textAlignment = .center
        gameTitle.numberOfLines = 0
        gameTitle.textColor = .black
        gameTitle.lineBreakMode = .byWordWrapping
        gameTitle.sizeToFit()
    }
    
    private func addGameImage() {
        containerView.addSubview(gameImage)
    }
    
    private func addGameDescription() {
        containerView.addSubview(gameDescription)
        gameDescription.numberOfLines = 0
        gameDescription.textColor = .black
        gameDescription.font = gameDescription.font.withSize(10)
        gameDescription.sizeToFit()
    }

}

extension DetailMovieViewController {
    func setIdGame(idGame: Int) {
        self.idGame = idGame
    }
    
    func getIdGame() -> Int {
        return idGame
    }
    
    func getGameTitle() -> UILabel {
        return gameTitle
    }
    
    func getGameImage() -> UIImageView {
        return gameImage
    }
    
    func getGameDescription() -> UILabel {
        return gameDescription
    }
    
}
