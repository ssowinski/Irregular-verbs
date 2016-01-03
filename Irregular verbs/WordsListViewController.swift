//
//  WordsListViewController.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 17.12.2015.
//  Copyright © 2015 Slawomir Sowinski. All rights reserved.
//

import UIKit

class WordsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    // MARK: - Constants
    private struct Const {
        static let Title = "Irregulars Verbs"
        static let CellReusedIdentifier = "CellReusedIdentifier"
        static let ShuffleBarButtonTitle = "Shuffle"
        static let BarButtonMenuImg = "BarButtonMenu"
        
        static let ColorBlue = UIColor(red:0.45, green:0.69, blue:0.68, alpha:1.0)    //#74AFAD
        static let ColorDarkGray = UIColor(red:0.33, green:0.33, blue:0.32, alpha:1.0)
    }
    
    // MARK: - Model
    private var verbsModel : VerbsModel
    
    // MARK: - Init
    init(verbsModel : VerbsModel) {
        self.verbsModel = verbsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - declaration and preparing UI
    private let verbsTableView = UITableView()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func layoutUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = Const.ColorBlue
        
        view.addSubview(verbsTableView)
        verbsTableView.dataSource = self
        verbsTableView.delegate = self
        verbsTableView.backgroundColor = Const.ColorDarkGray
        verbsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        verbsTableView.registerClass(VerbsTableViewCell.self, forCellReuseIdentifier: Const.CellReusedIdentifier)
        verbsTableView.estimatedRowHeight = 3//verbsTableView.rowHeight
        verbsTableView.rowHeight = UITableViewAutomaticDimension
        
        verbsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            verbsTableView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
            verbsTableView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor),
            verbsTableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            verbsTableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
            ])
    }
    
    private func setupNavigationBar() {
        title = Const.Title
        
        let shuffleBarButton = UIBarButtonItem(title: Const.ShuffleBarButtonTitle, style: .Plain, target: self, action: "shuffleAction:")
        shuffleBarButton.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = shuffleBarButton
        
        let menuBarButton = UIBarButtonItem(image:UIImage(named:Const.BarButtonMenuImg), style:.Plain, target:nil, action:nil)
        menuBarButton.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = menuBarButton
        //        self.navigationItem.backBarButtonItem = c
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.titleTextAttributes = [
            //            NSFontAttributeName: UIFont(name: "GothamPro", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
    }
    
    func shuffleAction(sender: UIBarButtonItem) {
        print("shuffleAction")
    }
    
    // MARK: - View Controller Lifecycle
    
    //If we don't override the loadView function, then UIViewController’s default implementation of loadView creates a generic UIView object and assigns it to self.view.
    //    override func loadView() {
    //        let view = UIView()
    //        self.view = view
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        layoutUI()
    }
    
    // MARK: -UITableViewDataSource Implemantation
    
    //    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    //    {
    //        return 1
    //    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verbsModel.countVerbs()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Const.CellReusedIdentifier) as? VerbsTableViewCell
        cell!.verb = verbsModel.getVerb(indexPath.row)
        return cell!
    }
    
    //    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //        return false
    //    }
    
    
    
}
