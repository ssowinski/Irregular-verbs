//
//  WordsListViewController.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 17.12.2015.
//  Copyright © 2015 Slawomir Sowinski. All rights reserved.
//

import UIKit

class WordsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonShowMoreDelegate, CardViewContainerDelegate
{
    // MARK: - Model
    private var verbsModel : VerbsModel
    
    
    // MARK: - UI declaration
    private let verbsTableView : UITableView
    
    // MARK: - Init
    init(verbsModel : VerbsModel = VerbsModel()) {
        self.verbsModel = verbsModel
        self.verbsTableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        layoutUI()
        
        verbsModel.fetchVerbs()
    }
    
    // MARK: - preparing UI
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func setupNavigationBar() {
        title = Const.String.VCTitle
        
        let shuffleBarButton = UIBarButtonItem(image:UIImage(named: Const.String.ShuffleBarButtonImg), style: .Plain, target: self, action: "shuffleAction:")
        shuffleBarButton.tintColor = UIColor.whiteColor()
        
        let sortBarButton = UIBarButtonItem(image: UIImage(named: Const.String.SortBarButtonImg), style: .Plain, target: self, action: "sortAction:")
        sortBarButton.tintColor = UIColor.whiteColor()
        
        navigationItem.setRightBarButtonItems([sortBarButton, shuffleBarButton], animated: true)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.titleTextAttributes = [
            //            NSFontAttributeName: UIFont(name: "GothamPro", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
    }
    
    private func layoutUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = Const.Color.Blue
        
        view.addSubview(verbsTableView)
        verbsTableView.dataSource = self
        verbsTableView.delegate = self
        verbsTableView.backgroundColor = Const.Color.DarkGray
        verbsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        verbsTableView.registerClass(VerbsTableViewCell.self, forCellReuseIdentifier: Const.String.CellReusedIdentifier)
        verbsTableView.estimatedRowHeight = Const.Size.EstimatedRowHeight //verbsTableView.rowHeight
        verbsTableView.rowHeight = UITableViewAutomaticDimension
        
        verbsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            verbsTableView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
            verbsTableView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor),
            verbsTableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            verbsTableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
            ])
    }
    
    func animateReloadDataInTableView(tableView : UITableView, duration: Double, delay: Double, spring: CGFloat, initSpring:CGFloat) {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.height
        
        for cell in cells {
            cell.transform = CGAffineTransformMakeTranslation(0, tableViewHeight)
        }
        
        var index = 0
        
        for cell in cells {
            UIView.animateWithDuration(duration, delay: delay * Double(index), usingSpringWithDamping: spring, initialSpringVelocity: initSpring, options: [], animations: {
                cell.transform = CGAffineTransformIdentity//CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    // MARK - Button action
    func shuffleAction(sender: UIBarButtonItem) {
        verbsModel.shuffleVerbs()
        animateReloadDataInTableView(verbsTableView, duration: Const.Size.TVAnimDuration, delay: Const.Size.TVAnimDelayFactor, spring: Const.Size.TVAnimSpringWithDamping, initSpring: Const.Size.TVAnimInitialSpringVelocity)
    }
    
    func sortAction(sender: UIBarButtonItem) {
        verbsModel.resetDefaultSort()
        animateReloadDataInTableView(verbsTableView, duration: Const.Size.TVAnimDuration, delay: Const.Size.TVAnimDelayFactor, spring: Const.Size.TVAnimSpringWithDamping, initSpring: Const.Size.TVAnimInitialSpringVelocity)
    }

    // MARK: -ButtonShowMoreDelegate Implemantation (for cell button)
    func buttonAction(cell: VerbsTableViewCell) {
        if let indexPath = verbsTableView.indexPathForCell(cell) {
            let cardViewContainer = CardViewContainer(frame: self.view.frame, startingIndex: indexPath.row)
            cardViewContainer.delegat = self
            self.view.addSubview(cardViewContainer)
        }
    }
    
    // MARK: -CardViewContainerDelegate Implemantation
    func cardsNumber(cardViewContainer: CardViewContainer) -> Int {
        return verbsModel.countVerbs()
    }
    
    func cardForIndex(cardViewContainer: CardViewContainer, index: Int) -> UIView {
        let card = CardView(frame: CGRect(x: 0, y: 0, width: Const.Size.CardWidth, height: Const.Size.CardHeight))
        card.verb = verbsModel.getVerb(index)
        return card
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Const.String.CellReusedIdentifier) as? VerbsTableViewCell
        cell?.verb = verbsModel.getVerb(indexPath.row)
        
        if cell?.buttonShowMoreDelegate == nil {
            cell?.buttonShowMoreDelegate = self
        }
        
        return cell!
    }
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        print("selecte \(verbsModel.getVerb(indexPath.row)?.getBaseForm())")
    //    }
    
    //    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //        return false
    //    }
    
}

