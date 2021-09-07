//
//  HomeViewController.swift
//  Game Catalog
//
//  Created by Mac on 03/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //private var currentContainerHeight: CGFloat = CGFloat(0)
    
    private let tabBar = CustomTabBar()
    
    private let titleLabel = UILabel()
    
    private let scrollView = UIScrollView()
    
    private let containerView = UIView()
    
    private let homeStackView: UIStackView = {
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
    
    private let collectionView: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 10
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flow)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .blue
        
        return collectionView
    }()
    
    private var presenter: HomeViewPresenterRule?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        addLayouts()
        addConstraints()
        
        presenter = HomeViewPresenter(view: self)
    }
    
    private func addLayouts() {
        addTabBar()
        addScollView()
        addContainerView()
        addTitleLabel()
        addCollectionView()
        addStackView()
    }
    
    private func addConstraints() {
        let views = ["tabBar": tabBar, "scrollView": scrollView, "containerView": containerView, "homeStackView": homeStackView, "collectionView": collectionView, "titleLabel": titleLabel]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let hScrollView = "H:|-5-[scrollView]-5-|"
        let hTabBar = "H:|-0-[tabBar]-0-|"
        let vTabBarScrollView = "V:|-0-[tabBar]-0-[scrollView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hScrollView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTabBar, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTabBarScrollView, options: .alignAllLeft, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: tabBar, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0)]
        //constraints += [NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)]
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let hContainerView = "H:|-0-[containerView]-0-|"
        let vContainerView = "V:|-0-[containerView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContainerView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContainerView, options: .alignAllLeft, metrics: metrix, views: views)
        //currentContainerHeight = CGFloat(Double(((Int(view.bounds.width) / 2) + 50)) * 14)
        //let containerViewHeigh = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: currentContainerHeight)
        //containerViewHeigh.identifier = "containerViewHeigh"
        
        //constraints += [containerViewHeigh]
        constraints += [NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)]
        
        
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let hStackView = "H:|-0-[homeStackView]-0-|"
        let vStackView = "V:|-0-[homeStackView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackView, options: .alignAllLeft, metrics: metrix, views: views)
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0)]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let defaultValue = NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(Double(((Int(view.bounds.width) / 2) + 50)) * 5))
        defaultValue.identifier = "collectionViewHeigh"
        constraints += [defaultValue]
//
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func addTabBar() {
        view.addSubview(tabBar)
        //tabBar.backgroundColor = .blue
    }
    
    private func addScollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.bounces = false
        scrollView.bouncesZoom = false
    }
    
    private func addContainerView() {
        scrollView.addSubview(containerView)
        containerView.backgroundColor = .white
    }
    
    private func addTitleLabel() {
        containerView.addSubview(titleLabel)
        
        titleLabel.text = "List Of Game"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .black
    }
    
    private func addCollectionView() {
        containerView.addSubview(collectionView)
    }
    
    private func addStackView() {
        containerView.addSubview(homeStackView)
        homeStackView.addArrangedSubview(titleLabel)
        homeStackView.addArrangedSubview(collectionView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("get memory issue")
    }

}

extension HomeViewController {
    func getCollectionView() -> UICollectionView {
        return collectionView
    }
    
    func getScrollView() -> UIScrollView {
        return scrollView
    }
    
    func updateContainerHeighConstraint(page: Int) {
        var constraints = collectionView.constraints
        
        
        guard let containerHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "collectionViewHeigh"
        }) else {
            return
        }
        
        print("Thread.isMainThread: \(Thread.isMainThread)")
        
        NSLayoutConstraint.deactivate(constraints)
//        let addValue = CGFloat(((Int(view.bounds.width) / 2) + (50 + (10 * (page * -1)))) * 5)
//        print("addValue: \(CGFloat(((Int(view.bounds.width) / 2) + (50 + (10 * (page * -1)))) * 5))")
//        print("currentContainerHeight: \(currentContainerHeight)")
//
//        currentContainerHeight += addValue
//
//        print("newConstraintValue: \(currentContainerHeight)")

        print("collectionView.contentSize.height: \(collectionView.contentSize.height)")
        
        constraints[containerHeigh] = NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: collectionView.collectionViewLayout.collectionViewContentSize.height)
        constraints[containerHeigh].identifier = "collectionViewHeigh"
        

        NSLayoutConstraint.activate(constraints)
        self.view.layoutIfNeeded()
    }
    
}
