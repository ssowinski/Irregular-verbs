//
//  MenuView.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 16.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

import UIKit

class SingleCardView: UIView {
    
    // MARK: - menu model (items list)
    private var verb : Verb? {
        didSet{
            updateUI()
        }
    }
    
    // MARK: - declaration and preparing UI
    private let menuContainerView = UIView()
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    private var animator : UIDynamicAnimator!
    private var menuWidth: CGFloat!
    private var menuHeight: CGFloat!
    
    
    init(menuWidth: CGFloat, menuHeight: CGFloat){
        super.init(frame: CGRectZero)
        self.menuHeight = menuHeight
        self.menuWidth = menuWidth
        animator = UIDynamicAnimator(referenceView: self)
        layoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnAction(sender : UIButton){
        hideCard()
    }
    
    override func didMoveToSuperview() {
        //        superview?.addSubview(overlayView)
    }
    
    private func layoutUI(){
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.grayColor()
        overlayView.alpha = 0.5
        addSubview(overlayView)
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            overlayView.topAnchor.constraintEqualToAnchor(self.topAnchor),
            overlayView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor),
            overlayView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor),
            overlayView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor)
            ])
        
        menuContainerView.frame = CGRectMake(-menuWidth, -menuHeight, menuWidth, menuHeight)
        menuContainerView.backgroundColor = Const.Color.Blue
        menuContainerView.layer.cornerRadius = Const.Size.CornerRadius
        //        menuContainerView.layer.shadowColor = UIColor.blackColor().CGColor
        //        menuContainerView.layer.shadowOffset = Const.ShadowOffset
        //        menuContainerView.layer.shadowOpacity = Const.ShadowOpacity
        //        menuContainerView.layer.shadowRadius = Const.ShadowRadius
        addSubview(menuContainerView)
        
        let menuTopBar = UIView(frame: CGRectMake(0, 0, menuWidth, Const.Size.CornerRadius))
        menuTopBar.backgroundColor = Const.Color.DarkBlue
        menuContainerView.addSubview(menuTopBar)
        
        btn1.setImage(UIImage(named: Const.String.ShowMoreButtonImg), forState: UIControlState.Normal)
        btn1.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        //        btn1.addTarget(self, action: Selector("dismissAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        
        btn2.setImage(UIImage(named: Const.String.ShuffleBarButtonImg), forState: UIControlState.Normal)
        btn2.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        btn3.setImage(UIImage(named: Const.String.SpeakButtonImg), forState: UIControlState.Normal)
        btn3.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // give the stack view arranged subviews
        let sv = UIStackView()
        sv.backgroundColor = UIColor.redColor()
        sv.addArrangedSubview(btn1)
        sv.addArrangedSubview(btn2)
        sv.addArrangedSubview(btn3)
        // configure the stack view
        sv.axis = .Vertical
        sv.alignment = .Center
        sv.distribution = .EqualCentering
        // constrain the stack view
        sv.translatesAutoresizingMaskIntoConstraints = false
        menuContainerView.addSubview(sv)
        NSLayoutConstraint.activateConstraints([
            sv.topAnchor.constraintEqualToAnchor(menuContainerView.layoutMarginsGuide.topAnchor),
            sv.leadingAnchor.constraintEqualToAnchor(menuContainerView.layoutMarginsGuide.leadingAnchor),
            sv.trailingAnchor.constraintEqualToAnchor(menuContainerView.layoutMarginsGuide.trailingAnchor),
            sv.bottomAnchor.constraintEqualToAnchor(menuContainerView.layoutMarginsGuide.bottomAnchor),
            ])
    }
    
    private func updateUI(){
        btn1.setTitle(verb?.getBaseForm(), forState: UIControlState.Normal)
        btn2.setTitle(verb?.getPastTense(), forState: UIControlState.Normal)
        btn3.setTitle(verb?.getPastParticiple(), forState: UIControlState.Normal)
    }
    
    func setVerb(verb:Verb) {
        self.verb = verb
    }
    
    func showCard(){
        UIView.animateWithDuration(Const.Size.AnimationDuration) {
            self.hidden = false
        }
        
        animator.removeAllBehaviors()
        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: menuContainerView, snapToPoint: self.center) //CGPointMake(0, 0))
        animator.addBehavior(snapBehaviour)
    }
    
    func hideCard(){
        animator.removeAllBehaviors()
        
        UIView.animateWithDuration(Const.Size.AnimationDuration, animations: {
            self.menuContainerView.frame.origin = CGPointMake(-self.menuWidth, -self.menuHeight)
            }, completion: {
                (value: Bool) in
                self.hidden = true
        })
    }
    
    /*
    // Only override drawRect:  you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
