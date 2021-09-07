//
//  LoadingBar.swift
//  Game Catalog
//
//  Created by Mac on 04/09/21.
//

import UIKit

class LoadingBar: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

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
        
    }
    
    private func addConstraints() {
        
    }
    
    
    
}
