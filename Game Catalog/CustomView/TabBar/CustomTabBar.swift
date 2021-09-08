//
//  CustomTabBar.swift
//  Game Catalog
//
//  Created by Mac on 04/09/21.
//

import UIKit

class CustomTabBar: UIView {

    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let borderView = UIView()
    private let contentView = UIView()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
    
    var isLeftButtonHidden: Bool = false {
        didSet {
            leftButton.isHidden = isLeftButtonHidden
        }
    }
    
    var isRightButtonHidden: Bool = false {
        didSet {
            rightButton.isHidden = isRightButtonHidden
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        addLayout()
        addConstraints()
    }
    
    private func addLayout() {
        addBorderView()
        addContentView()
        addRightButton()
        addLeftButton()
    }
    
    private func addConstraints() {
        
        let views = ["borderView": borderView, "contentView": contentView, "leftButton": leftButton, "rightButton": rightButton]
        
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        let hBorderView = "H:|-0-[borderView]-0-|"
        let vBorderView = "V:|-0-[borderView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hBorderView, options: .alignAllCenterY, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vBorderView, options: .alignAllCenterX, metrics: metrix, views: views)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hContentView = "H:|-3-[contentView]-3-|"
        let vContentView = "V:|-3-[contentView]-3-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentView, options: .alignAllCenterY, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentView, options: .alignAllCenterX, metrics: metrix, views: views)
        
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        let vLeftButton = "V:|-0-[leftButton]-0-|"
        
        constraints += [NSLayoutConstraint(item: leftButton, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 5)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLeftButton, options: .alignAllLeading, metrics: metrix, views: views)
        // constraints += [NSLayoutConstraint(item: leftButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10)]
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        let vRightButton = "V:|-0-[rightButton]-0-|"
        
        constraints += [NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: rightButton, attribute: .trailing, multiplier: 1, constant: 5)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vRightButton, options: .alignAllTrailing, metrics: metrix, views: views)
        // constraints += [NSLayoutConstraint(item: rightButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10)]
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    private func addBorderView() {
        self.addSubview(borderView)
        borderView.backgroundColor = .black
    }
    
    private func addContentView() {
        borderView.addSubview(contentView)
        contentView.backgroundColor = .white
    }
    
    private func addRightButton() {
        contentView.addSubview(rightButton)
        rightButton.backgroundColor = .white
        setRightButtonText(text: "-")
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonTap), for: .touchDown)
    }
    
    private func addLeftButton() {
        contentView.addSubview(leftButton)
        leftButton.backgroundColor = .white
        setLeftButtonText(text: "-")
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonTap), for: .touchDown)
    }
    
    
    func setRightButtonText(text: String) {
        rightButton.setTitle(text, for: .normal)
    }
    
    func setLeftButtonText(text: String) {
        leftButton.setTitle(text, for: .normal)
    }

}

extension CustomTabBar {
    @objc private func leftButtonTap() {
        leftButtonAction?()
    }
    
    @objc private func rightButtonTap() {
        rightButtonAction?()
    }
}
