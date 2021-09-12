//
//  GameCollectionViewCell.swift
//  Game Catalog
//
//  Created by Mac on 04/09/21.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
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
    private let borderView = UIView()
    private let containerView = UIView()
    private let gameImage = UIImageView()
    private let gameTitle = UILabel()
    private let ratingBox = UIView()
    private let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 5
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
    
    private var presenter: GameCollectionViewCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        presenter = GameCollectionViewCellPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setup() {
        addLayout()
        addConstraints()
    }
    
    private func addLayout() {
        self.contentView.backgroundColor = .white
        addBorderView()
        addContainerView()
        addGameImage()
        addGameLabel()
        addRatingBox()
        addExceptionalRating()
        addRecommendedRating()
        addMehRating()
        addSkipRating()
        addContentStackView()
    }
    
    private func addConstraints() {
        let views = ["borderView": borderView, "contentStackView": contentStackView, "containerView": containerView, "gameImage": gameImage, "gameTitle": gameTitle, "ratingBox": ratingBox, "ratingStackView": ratingStackView, "exceptionalLabel": exceptionalLabel, "exceptionalCountLabel": exceptionalCountLabel, "exceptionalPercenBar": exceptionalPercenBar, "exceptionalPercenFill": exceptionalPercenFill, "recommendedStackView": recommendedStackView, "recommendedLabel": recommendedLabel, "recommendedCountLabel": recommendedCountLabel, "recommendedPercenBar": recommendedPercenBar, "recommendedPercenFill": recommendedPercenFill, "mehLabel": mehLabel, "mehCountLabel": mehCountLabel, "mehPercenBar": mehPercenBar, "mehPercenFill": mehPercenFill, "skipLabel": skipLabel, "skipCountLabel": skipCountLabel, "skipPercenBar": skipPercenBar, "skipPercenFill": skipPercenFill]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        let hBorderView = "H:|-0-[borderView]-0-|"
        let vBorderView = "V:|-0-[borderView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hBorderView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vBorderView, options: .alignAllLeading, metrics: metrix, views: views)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let hContainerView = "H:|-1-[containerView]-1-|"
        let vContainerView = "V:|-1-[containerView]-1-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContainerView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContainerView, options: .alignAllLeading, metrics: metrix, views: views)
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-5-[contentStackView]-5-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        ratingBox.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: ratingBox, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 3/9, constant: 0)]
        
        gameImage.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        constraints += [NSLayoutConstraint(item: gameTitle, attribute: .height, relatedBy: .equal, toItem: gameImage, attribute: .height, multiplier: 3/9, constant: 0)]
        
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        let hRatingStackView = "H:|-0-[ratingStackView]-0-|"
        let vRatingStackView = "V:|-0-[ratingStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hRatingStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vRatingStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        exceptionalLabel.translatesAutoresizingMaskIntoConstraints = false
        exceptionalCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: exceptionalLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: exceptionalCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        exceptionalPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vExceptionalPercenFill = "V:|-0-[exceptionalPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: exceptionalPercenFill, attribute: .leading, relatedBy: .equal, toItem: exceptionalPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vExceptionalPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendedCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: recommendedLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: recommendedCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        recommendedPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vRecommendedPercenFill = "V:|-0-[recommendedPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: recommendedPercenFill, attribute: .leading, relatedBy: .equal, toItem: recommendedPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vRecommendedPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        mehLabel.translatesAutoresizingMaskIntoConstraints = false
        mehCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: mehLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: mehCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        mehPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vMehPercenFill = "V:|-0-[mehPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: mehPercenFill, attribute: .leading, relatedBy: .equal, toItem: mehPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vMehPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        skipLabel.translatesAutoresizingMaskIntoConstraints = false
        skipCountLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: skipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        constraints += [NSLayoutConstraint(item: skipCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        skipPercenFill.translatesAutoresizingMaskIntoConstraints = false
        let vSkipPercenFill = "V:|-0-[skipPercenFill]-0-|"
        constraints += [NSLayoutConstraint(item: skipPercenFill, attribute: .leading, relatedBy: .equal, toItem: skipPercenBar, attribute: .leading, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vSkipPercenFill, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func addBorderView() {
        self.contentView.addSubview(borderView)
        borderView.backgroundColor = .black
    }
    
    private func addContainerView() {
        borderView.addSubview(containerView)
        containerView.backgroundColor = .white
    }
    
    private func addGameImage() {
        containerView.addSubview(gameImage)
        gameImage.image = #imageLiteral(resourceName: "game")
        gameImage.contentMode = .scaleAspectFit
    }
    
    private func addGameLabel() {
        containerView.addSubview(gameTitle)
        gameTitle.text = ""
        gameTitle.font = UIFont.boldSystemFont(ofSize: 10)
        gameTitle.textAlignment = .center
        gameTitle.numberOfLines = 0
        gameTitle.textColor = .black
        gameTitle.lineBreakMode = .byWordWrapping
        gameTitle.sizeToFit()
    }
    
    private func addRatingBox() {
        containerView.addSubview(ratingBox)
    }
    
    private func addContentStackView() {
        containerView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(gameImage)
        contentStackView.addArrangedSubview(gameTitle)
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
    }
    
    private func addExceptionalRating() {
        ratingBox.addSubview(exceptionalLabel)
        ratingBox.addSubview(exceptionalPercenBar)
        ratingBox.addSubview(exceptionalCountLabel)
        exceptionalPercenBar.addSubview(exceptionalPercenFill)
        exceptionalLabel.textColor = .black
        exceptionalCountLabel.textColor = .black
        exceptionalLabel.font = exceptionalLabel.font.withSize(8)
        exceptionalCountLabel.font = exceptionalCountLabel.font.withSize(8)
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
        recommendedLabel.font = exceptionalLabel.font.withSize(6)
        recommendedCountLabel.font = exceptionalCountLabel.font.withSize(8)
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
        mehCountLabel.font = exceptionalCountLabel.font.withSize(8)
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
        skipCountLabel.font = exceptionalCountLabel.font.withSize(8)
        skipCountLabel.textAlignment = .center
        skipPercenBar.backgroundColor = .gray
        skipPercenFill.backgroundColor = .black
        skipPercenFill.bounds.size.width = 1
        
        skipLabel.text = "Skip"
        skipCountLabel.text = "0"
    }
}

extension GameCollectionViewCell {
    func setupData(item: Game) {
        gameTitle.text = item.name
        // gameImage.setImage(url: "https://i1.sndcdn.com/artworks-000513975783-35fqbz-t500x500.jpg", times: 3)
        gameImage.setImage(url: item.name)
        presenter?.setupRatingValue(ratings: item.ratings)
        
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
