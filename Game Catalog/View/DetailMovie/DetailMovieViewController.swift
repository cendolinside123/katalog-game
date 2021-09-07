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
    private let gameDescription = UIImage()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
    }
    
    private func addConstraint() {
        let views = ["tabBar": tabBar, "scrollView": scrollView, "contentStackView": contentStackView, "gameTitle": gameTitle, "gameImage": gameImage, "gameDescription": gameDescription]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
    }
    
    

}
