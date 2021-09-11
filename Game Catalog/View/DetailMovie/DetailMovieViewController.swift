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
        stack.spacing = 10
        stack.layoutMargins.left = 10
        stack.layoutMargins.right = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let gameDescription = UILabel()
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let ratingBox = UIView()
    private let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let exceptionalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let recommendedStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let mehStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let skipStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    private let exceptionalLabel = UILabel()
    private let exceptionalCountLabel = UILabel()
    private let exceptionalPercenBar = UIView()
    private let exceptionalPercenFill = UIView()
    
    private let recommendedLabel = UILabel()
    private let recommendedCountLabel = UILabel()
    private let recommendedPercenBar = UIView()
    private let recommendedPercenFill = UIView()
    
    private let mehLabel = UILabel()
    private let mehCountLabel = UILabel()
    private let mehPercenBar = UIView()
    private let mehPercenFill = UIView()
    
    private let skipLabel = UILabel()
    private let skipCountLabel = UILabel()
    private let skipPercenBar = UIView()
    private let skipPercenFill = UIView()
    
    private let emptyView = UIView()
    
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
        addRatingBox()
        addExceptionalRating()
        addRecommendedRating()
        addMehRating()
        addSkipRating()
        addEptyView()
        addContentStackView()
    }
    
    private func addConstraint() {
        let views = ["tabBar": tabBar, "scrollView": scrollView, "contentStackView": contentStackView, "gameTitle": gameTitle, "gameImage": gameImage, "gameDescription": gameDescription, "containerView": containerView, "ratingBox": ratingBox, "ratingStackView": ratingStackView, "exceptionalLabel": exceptionalLabel, "exceptionalCountLabel": exceptionalCountLabel, "exceptionalPercenBar": exceptionalPercenBar, "exceptionalPercenFill": exceptionalPercenFill, "recommendedStackView": recommendedStackView, "recommendedLabel": recommendedLabel, "recommendedCountLabel": recommendedCountLabel, "recommendedPercenBar": recommendedPercenBar, "recommendedPercenFill": recommendedPercenFill, "mehLabel": mehLabel, "mehCountLabel": mehCountLabel, "mehPercenBar": mehPercenBar, "mehPercenFill": mehPercenFill, "skipLabel": skipLabel, "skipCountLabel": skipCountLabel, "skipPercenBar": skipPercenBar, "skipPercenFill": skipPercenFill, "emptyView": emptyView]
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
        constraints += [NSLayoutConstraint(item: tabBar, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0)]
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let hContainerView = "H:|-0-[containerView]-0-|"
        let vContainerView = "V:|-0-[containerView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContainerView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContainerView, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)]
        // constraints += [NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)]
        
        
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
        
        ratingBox.translatesAutoresizingMaskIntoConstraints = false
//        constraints += [NSLayoutConstraint(item: ratingBox, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 8/10, constant: 0)]
        
        
        exceptionalStackView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: exceptionalStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        
        recommendedStackView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: recommendedStackView, attribute: .height, relatedBy: .equal, toItem: exceptionalStackView, attribute: .height, multiplier: 1, constant: 0)]
        
        mehStackView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: mehStackView, attribute: .height, relatedBy: .equal, toItem: exceptionalStackView, attribute: .height, multiplier: 1, constant: 0)]
        
        skipStackView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: skipStackView, attribute: .height, relatedBy: .equal, toItem: exceptionalStackView, attribute: .height, multiplier: 1, constant: 0)]
        
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        let hRatingStackView = "H:|-0-[ratingStackView]-0-|"
        let vRatingStackView = "V:|-0-[ratingStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hRatingStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vRatingStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        exceptionalLabel.translatesAutoresizingMaskIntoConstraints = false
        exceptionalCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: exceptionalLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        constraints += [NSLayoutConstraint(item: exceptionalCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        exceptionalPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vExceptionalPercenFill = "V:|-0-[exceptionalPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: exceptionalPercenFill, attribute: .leading, relatedBy: .equal, toItem: exceptionalPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vExceptionalPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendedCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: recommendedLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        constraints += [NSLayoutConstraint(item: recommendedCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        recommendedPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vRecommendedPercenFill = "V:|-0-[recommendedPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: recommendedPercenFill, attribute: .leading, relatedBy: .equal, toItem: recommendedPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vRecommendedPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        mehLabel.translatesAutoresizingMaskIntoConstraints = false
        mehCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: mehLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        constraints += [NSLayoutConstraint(item: mehCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        mehPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vMehPercenFill = "V:|-0-[mehPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: mehPercenFill, attribute: .leading, relatedBy: .equal, toItem: mehPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vMehPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        skipLabel.translatesAutoresizingMaskIntoConstraints = false
        skipCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: skipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        constraints += [NSLayoutConstraint(item: skipCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        skipPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vSkipPercenFill = "V:|-0-[skipPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: skipPercenFill, attribute: .leading, relatedBy: .equal, toItem: skipPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vSkipPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: emptyView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        
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
        contentStackView.addArrangedSubview(ratingBox)
        
        ratingBox.addSubview(ratingStackView)
        ratingBox.addSubview(exceptionalStackView)
        ratingBox.addSubview(recommendedStackView)
        ratingBox.addSubview(mehStackView)
        ratingBox.addSubview(skipStackView)
        
        ratingStackView.addArrangedSubview(exceptionalStackView)
        exceptionalStackView.addArrangedSubview(exceptionalLabel)
        exceptionalStackView.addArrangedSubview(exceptionalPercenBar)
        exceptionalStackView.addArrangedSubview(exceptionalCountLabel)
        
        ratingStackView.addArrangedSubview(recommendedStackView)
        recommendedStackView.addArrangedSubview(recommendedLabel)
        recommendedStackView.addArrangedSubview(recommendedPercenBar)
        recommendedStackView.addArrangedSubview(recommendedCountLabel)
        
        ratingStackView.addArrangedSubview(mehStackView)
        mehStackView.addArrangedSubview(mehLabel)
        mehStackView.addArrangedSubview(mehPercenBar)
        mehStackView.addArrangedSubview(mehCountLabel)
        
        ratingStackView.addArrangedSubview(skipStackView)
        skipStackView.addArrangedSubview(skipLabel)
        skipStackView.addArrangedSubview(skipPercenBar)
        skipStackView.addArrangedSubview(skipCountLabel)
        
        contentStackView.addArrangedSubview(emptyView)
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
    
    private func addRatingBox() {
        containerView.addSubview(ratingBox)
    }

    private func addExceptionalRating() {
        ratingBox.addSubview(exceptionalLabel)
        ratingBox.addSubview(exceptionalPercenBar)
        ratingBox.addSubview(exceptionalCountLabel)
        exceptionalPercenBar.addSubview(exceptionalPercenFill)
        exceptionalLabel.textColor = .black
        exceptionalCountLabel.textColor = .black
        exceptionalLabel.font = exceptionalLabel.font.withSize(10)
        exceptionalCountLabel.font = exceptionalCountLabel.font.withSize(10)
        exceptionalCountLabel.textAlignment = .center
        exceptionalPercenBar.backgroundColor = .gray
        exceptionalPercenFill.backgroundColor = .green
        exceptionalPercenFill.bounds.size.width = 1
        
        exceptionalLabel.text = "Exceptional"
        exceptionalCountLabel.text = "0"
    }
    
    private func addRecommendedRating() {
        ratingBox.addSubview(recommendedLabel)
        ratingBox.addSubview(recommendedPercenBar)
        ratingBox.addSubview(recommendedCountLabel)
        recommendedPercenBar.addSubview(recommendedPercenFill)
        recommendedLabel.textColor = .black
        recommendedCountLabel.textColor = .black
        recommendedLabel.font = exceptionalLabel.font.withSize(10)
        recommendedCountLabel.font = exceptionalCountLabel.font.withSize(10)
        recommendedCountLabel.textAlignment = .center
        recommendedPercenBar.backgroundColor = .gray
        recommendedPercenFill.backgroundColor = .blue
        recommendedPercenFill.bounds.size.width = 50
        
        recommendedLabel.text = "Recommended"
        recommendedCountLabel.text = "0"
    }
    
    private func addMehRating() {
        ratingBox.addSubview(mehLabel)
        ratingBox.addSubview(mehPercenBar)
        ratingBox.addSubview(mehCountLabel)
        mehPercenBar.addSubview(mehPercenFill)
        mehLabel.textColor = .black
        mehCountLabel.textColor = .black
        mehLabel.font = exceptionalLabel.font.withSize(10)
        mehCountLabel.font = exceptionalCountLabel.font.withSize(10)
        mehCountLabel.textAlignment = .center
        mehPercenBar.backgroundColor = .gray
        mehPercenFill.backgroundColor = .red
        mehPercenFill.bounds.size.width = 1
        
        mehLabel.text = "Meh"
        mehCountLabel.text = "0"
    }
    
    private func addSkipRating() {
        ratingBox.addSubview(skipLabel)
        ratingBox.addSubview(skipPercenBar)
        ratingBox.addSubview(skipCountLabel)
        skipPercenBar.addSubview(skipPercenFill)
        skipCountLabel.textColor = .black
        mehCountLabel.textColor = .black
        skipLabel.font = exceptionalLabel.font.withSize(10)
        skipCountLabel.font = exceptionalCountLabel.font.withSize(10)
        skipCountLabel.textAlignment = .center
        skipPercenBar.backgroundColor = .gray
        skipPercenFill.backgroundColor = .black
        skipPercenFill.bounds.size.width = 1
        
        skipLabel.text = "Skip"
        skipCountLabel.text = "0"
    }
    
    private func addEptyView() {
        containerView.addSubview(emptyView)
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
    
    func getExceptionalCountLabel() -> UILabel {
        return exceptionalCountLabel
    }
    
    func getRecommendedCountLabel() -> UILabel {
        return recommendedCountLabel
    }
    
    func getMehCountLabel() -> UILabel {
        return mehCountLabel
    }
    
    func getSkipCountLabel() -> UILabel {
        return skipCountLabel
    }
    
    func returnGameImage() -> UIImageView {
        return gameImage
    }
    
    func getExceptionalPercenFill() -> UIView {
        return exceptionalPercenFill
    }
    
    func getRecommendedPercenFill() -> UIView {
        return recommendedPercenFill
    }
    
    func getMehPercenFill() -> UIView {
        return mehPercenFill
    }
    
    func getSkipPercenFill() -> UIView {
        return skipPercenFill
    }
    
    func getExceptionalPercenBar() -> UIView {
        return exceptionalPercenBar
    }
    
    func getRecommendedPercentBar() -> UIView {
        return recommendedPercenBar
    }
    
    func getMehPercentBar() -> UIView {
        return mehPercenBar
    }
    
    func getSkipPercentBar() -> UIView {
        return skipPercenBar
    }
}
