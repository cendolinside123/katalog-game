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
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
        addContentStackView()
    }
    
    private func addConstraints() {
        let views = ["borderView": borderView, "contentStackView": contentStackView, "containerView": containerView, "gameImage": gameImage, "gameTitle": gameTitle, "ratingBox": ratingBox, "ratingStackView": ratingStackView]
        let metrix: [String:Any] = [:]
        
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
        
        constraints += [NSLayoutConstraint(item: gameTitle, attribute: .height, relatedBy: .equal, toItem: gameImage, attribute: .height, multiplier: 2/9, constant: 0)]
        
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
    }
    
    private func addRatingBox() {
        containerView.addSubview(ratingBox)
    }
    
    private func addContentStackView() {
        containerView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(gameImage)
        contentStackView.addArrangedSubview(gameTitle)
        contentStackView.addArrangedSubview(ratingBox)
        
    }
}

extension GameCollectionViewCell {
    func setupData(item: Game) {
        gameTitle.text = item.name
        gameImage.setImage(url: item.backgroundImage, times: 3)
        
    }
    
    func returnGameImage() -> UIImageView {
        return gameImage
    }
    
}
