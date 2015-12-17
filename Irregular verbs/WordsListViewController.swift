//
//  WordsListViewController.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 17.12.2015.
//  Copyright © 2015 Slawomir Sowinski. All rights reserved.
//

import UIKit

class WordsListViewController: UIViewController {
    

//    override func loadView() {
//        let view = UIView()
//        self.view = view
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blueColor()
        
        let label = UILabel()
        self.view.addSubview(label)
        
        label.text = "Verbs!"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            label.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor),
            label.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor),
            ])
    }
}
