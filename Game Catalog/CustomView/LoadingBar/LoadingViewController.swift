//
//  LoadingViewController.swift
//  Game Catalog
//
//  Created by Mac on 12/09/21.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let loadingBox = UIView()
    let loadingText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        addLayout()
        addConstraint()
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dismissSelf)))
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
        addLoadingBox()
        addLoadingText()
    }
    
    private func addConstraint() {
        let views = ["loadingBox": loadingBox, "loadingText": loadingText]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        loadingBox.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingBox, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)]
        constraints += [NSLayoutConstraint(item: loadingBox, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)]
        constraints += [NSLayoutConstraint(item: loadingBox, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingBox, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)]
        
        
        loadingText.translatesAutoresizingMaskIntoConstraints = false
        let hLoadingText = "H:|-[loadingText]-|"
        constraints += [NSLayoutConstraint(item: loadingText, attribute: .centerX, relatedBy: .equal, toItem: loadingBox, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingText, attribute: .centerY, relatedBy: .equal, toItem: loadingBox, attribute: .centerY, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingText, attribute: .height, relatedBy: .equal, toItem: loadingBox, attribute: .height, multiplier: 1, constant: 0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingText, options: .alignAllCenterY, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLoadingBox() {
        view.addSubview(loadingBox)
        loadingBox.backgroundColor = .white
    }
    
    private func addLoadingText() {
        loadingBox.addSubview(loadingText)
        loadingText.text = "Now Loading ...."
        loadingText.font = UIFont.boldSystemFont(ofSize: 15)
        loadingText.textColor = .black
        loadingText.textAlignment = .center
        loadingText.backgroundColor = .white
        loadingBox.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dismissSelf)))
    }
    
    @objc private func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }

}
