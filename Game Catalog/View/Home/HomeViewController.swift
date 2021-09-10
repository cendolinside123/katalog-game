//
//  HomeViewController.swift
//  Game Catalog
//
//  Created by Mac on 03/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
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
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private let loadingNotif = UIView()
    private let loadingText = UITextView()
    
    private let floatingAbout = UIView()
    private let textAboutMe = UILabel()
    
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
        addLoadingNotif()
        addFloatingAbout()
    }
    
    private func addConstraints() {
        let views = ["tabBar": tabBar, "scrollView": scrollView, "containerView": containerView, "homeStackView": homeStackView, "collectionView": collectionView, "titleLabel": titleLabel, "loadingNotif": loadingNotif, "loadingText": loadingText, "textAboutMe": textAboutMe]
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
        // constraints += [NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)]
        
        
        
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let hStackView = "H:|-0-[homeStackView]-0-|"
        let vStackView = "V:|-0-[homeStackView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackView, options: .alignAllLeft, metrics: metrix, views: views)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let hContainerView = "H:|-0-[containerView]-0-|"
        let vContainerView = "V:|-0-[containerView]-0-|"

        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContainerView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContainerView, options: .alignAllLeft, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)]
        let containerHeight = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)
        containerHeight.identifier = "containerHeight"
        
        constraints += [containerHeight]

        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0)]
        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        let defaultValue = NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(Double(((Int(view.bounds.width) / 2) + 50)) * 5))
//        defaultValue.identifier = "collectionViewHeigh"
//        constraints += [defaultValue]
//
        
        loadingNotif.translatesAutoresizingMaskIntoConstraints = false
        
        let hLoadingNotif = "H:|-0-[loadingNotif]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingNotif, options: .alignAllTop, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: loadingNotif, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35)]
        let loadingBottomConstraint = NSLayoutConstraint(item: loadingNotif, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 70)
        loadingBottomConstraint.identifier = "loadingBottomConstraint"
        constraints += [loadingBottomConstraint]
        
        
        loadingText.translatesAutoresizingMaskIntoConstraints = false
        
        let hLoadingText = "H:|-[loadingText]-|"
        constraints += [NSLayoutConstraint(item: loadingText, attribute: .centerX, relatedBy: .equal, toItem: loadingNotif, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingText, attribute: .centerY, relatedBy: .equal, toItem: loadingNotif, attribute: .centerY, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingText, attribute: .height, relatedBy: .equal, toItem: loadingNotif, attribute: .height, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingText, options: .alignAllCenterY, metrics: metrix, views: views)
        
        
        textAboutMe.translatesAutoresizingMaskIntoConstraints = false
        
        let hTextAboutMe = "H:|-0-[textAboutMe]-0-|"
        let vTextAboutMe = "V:|-0-[textAboutMe]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTextAboutMe, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTextAboutMe, options: .alignAllLeft, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func addTabBar() {
        view.addSubview(tabBar)
        // tabBar.backgroundColor = .blue
    }
    
    private func addScollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.bounces = false
        scrollView.bouncesZoom = false
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
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
    
    private func addLoadingNotif() {
        view.addSubview(loadingNotif)
        loadingNotif.addSubview(loadingText)
        loadingNotif.backgroundColor = .gray
        loadingNotif.alpha = 0
        
        loadingText.text = "Now Loading ...."
        loadingText.font = UIFont.boldSystemFont(ofSize: 15)
        loadingText.textColor = .black
        loadingText.textAlignment = .center
        loadingText.backgroundColor = .none
        loadingText.alpha = 0
    }
    
    private func addFloatingAbout() {
        view.addSubview(floatingAbout)
        floatingAbout.addSubview(textAboutMe)
        
        floatingAbout.backgroundColor = .red
        
        floatingAbout.frame.size.height = 50
        floatingAbout.frame.size.width = 50
        floatingAbout.frame.origin.x = (view.frame.width * 3) / 4
        floatingAbout.frame.origin.y = (view.frame.height * 4) / 5
        
        textAboutMe.text = "About Me"
        textAboutMe.textAlignment = .center
        textAboutMe.numberOfLines = 0
        textAboutMe.textColor = .black
        textAboutMe.lineBreakMode = .byWordWrapping
        textAboutMe.sizeToFit()
        
        
        floatingAbout.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragAboutMe(gesture:))))
        floatingAbout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAboutMe(tap:))))
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
    
    func showLoadingNotifNoAnimation() {
        var constraints = view.constraints
        
        guard let bottomConstraint = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingBottomConstraint"
        }) else {
            return
        }
        
        NSLayoutConstraint.deactivate(constraints)
        constraints[bottomConstraint] = NSLayoutConstraint(item: loadingNotif, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        constraints[bottomConstraint].identifier = "loadingBottomConstraint"
        NSLayoutConstraint.activate(constraints)
        loadingNotif.alpha = 1
        loadingText.alpha = 1
        view.layoutIfNeeded()
    }
    
    func showLoadingNotif() {
        var constraints = view.constraints
        
        guard let bottomConstraint = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingBottomConstraint"
        }) else {
            return
        }
        
        NSLayoutConstraint.deactivate(constraints)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let superSelf = self else {
                return
            }
            
            constraints[bottomConstraint] = NSLayoutConstraint(item: superSelf.loadingNotif, attribute: .bottom, relatedBy: .equal, toItem: superSelf.view, attribute: .bottom, multiplier: 1, constant: 0)
            constraints[bottomConstraint].identifier = "loadingBottomConstraint"
            NSLayoutConstraint.activate(constraints)
            superSelf.loadingNotif.alpha = 1
            superSelf.loadingText.alpha = 1
            superSelf.view.layoutIfNeeded()
        })
        
        
    }
    
    func hideLoadingNofif() {
        var constraints = view.constraints
        
        guard let bottomConstraint = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingBottomConstraint"
        }) else {
            return
        }
        
        NSLayoutConstraint.deactivate(constraints)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let superSelf = self else {
                return
            }
            
            constraints[bottomConstraint] = NSLayoutConstraint(item: superSelf.loadingNotif, attribute: .bottom, relatedBy: .equal, toItem: superSelf.view, attribute: .bottom, multiplier: 1, constant: 70)
            constraints[bottomConstraint].identifier = "loadingBottomConstraint"
            NSLayoutConstraint.activate(constraints)
            superSelf.loadingNotif.alpha = 0
            superSelf.loadingText.alpha = 0
            superSelf.view.layoutIfNeeded()
        })
        
    }
    
    func updateCollectionHeighConstraint() {
        var constraints = collectionView.constraints
        guard let containerHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "collectionViewHeigh"
        }) else {
            return
        }
        
        print("Thread.isMainThread: \(Thread.isMainThread)")
        
        NSLayoutConstraint.deactivate(constraints)

        print("collectionView.contentSize.height: \(collectionView.contentSize.height)")
        
        constraints[containerHeigh] = NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: collectionView.collectionViewLayout.collectionViewContentSize.height)
        constraints[containerHeigh].identifier = "collectionViewHeigh"
        

        NSLayoutConstraint.activate(constraints)
//        self.view.layoutIfNeeded()
    }
    
    func increaseContainerHeight() {
        var constraints = scrollView.constraints
        
        guard let containerHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "containerHeight"
        }) else {
            return
        }
        
        print("Thread.isMainThread: \(Thread.isMainThread)")
        
        NSLayoutConstraint.deactivate(constraints)

        print("containerView.frame.height: \(containerView.frame.height) , containerView.frame.origin.x: \(containerView.frame.origin.x)")
        
        constraints[containerHeigh] = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: titleLabel.frame.height)
        constraints[containerHeigh].identifier = "containerHeight"
        NSLayoutConstraint.activate(constraints)
//        self.view.layoutIfNeeded()
    }
    
    func decreaseContainerHeight() {
        var constraints = scrollView.constraints
        
        guard let containerHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "containerHeight"
        }) else {
            return
        }
        
        print("Thread.isMainThread: \(Thread.isMainThread)")
        
        NSLayoutConstraint.deactivate(constraints)

        print("containerView.height: \(containerView.frame.height) , containerView.frame.origin.x: \(containerView.frame.origin.x)")
        
        constraints[containerHeigh] = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)
        constraints[containerHeigh].identifier = "containerHeight"
        NSLayoutConstraint.activate(constraints)
        self.view.layoutIfNeeded()
    }
    
    func getTitle() -> UILabel {
        return titleLabel
    }
    
    func getContainer() -> UIView {
        return containerView
    }
    
}

extension HomeViewController {
    @objc private func dragAboutMe(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.floatingAbout.frame.midX >= self.view.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.floatingAbout.center.x = self.view.layer.frame.width - 40
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.floatingAbout.center.x = 40
                }, completion: nil)
            }
            
            if self.floatingAbout.frame.origin.y > 0 {
                if self.floatingAbout.frame.maxY >= self.view.layer.frame.height {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                        self.floatingAbout.frame.origin.y -= 40
                    }, completion: nil)
                } else {
                    
                }
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.floatingAbout.frame.origin.y = 40
                }, completion: nil)
            }
            
        }
    }
    
    @objc private func tapAboutMe(tap: UITapGestureRecognizer) {
        let aboutMe = AboutViewController()
        self.present(aboutMe, animated: true, completion: nil)
    }
}
