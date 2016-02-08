//
//  CardViewContainer.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 30.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//


import UIKit

protocol CardViewContainerDelegate: class {
    func cardsNumber(cardViewContainer : CardViewContainer) -> Int
    func cardForIndex(cardViewContainer : CardViewContainer, index: Int) -> UIView
}

private enum SwipeDirection {
    case Left
    case Right
}

class CardViewContainer: UIView {
    
    weak var delegat : CardViewContainerDelegate? {
        didSet {
            showCard(currentIndex, swipeDir: .Left)
        }
    }
    
    private var currentIndex : Int
    private var animator : UIDynamicAnimator!
    private var attachmentBehavior : UIAttachmentBehavior!
    
    private var cardView : UIView?
    
    init(frame: CGRect, startingIndex: Int) {
        self.currentIndex = startingIndex
        super.init(frame: frame)
        self.animator = UIDynamicAnimator(referenceView: self)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        let alphaBackground = UIView(frame: self.frame)
        alphaBackground.backgroundColor = UIColor.blackColor()
        alphaBackground.alpha = Const.Size.CardBackgroundAlpha
        addSubview(alphaBackground)
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.frame
//        addSubview(blurEffectView)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        alphaBackground.addGestureRecognizer(tapRecognizer)
    }
    
    private func showCard(index: Int, swipeDir: SwipeDirection) {
        guard let card = delegat?.cardForIndex(self, index: index) else { return }
        
        addSubview(card)
        animator.removeAllBehaviors()
        let snapBehaviour: UISnapBehavior = UISnapBehavior(item: card, snapToPoint: self.center) //CGPointMake(0, 0))
        animator.addBehavior(snapBehaviour)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "pan:")
        card.addGestureRecognizer(panRecognizer)
        
        self.cardView = card
    }
    
    private func dismissCardViewContainer() {
        animator.removeAllBehaviors()
        
        if let card = cardView {
            let gravityBehaviour = UIGravityBehavior(items: [card])
            gravityBehaviour.gravityDirection = CGVectorMake(Const.Size.GravityDownVexctorTuple);
            animator.addBehavior(gravityBehaviour)
            
            let itemBehaviour = UIDynamicItemBehavior(items: [card])
            itemBehaviour.addAngularVelocity(CGFloat(M_PI_2), forItem: card)
            animator.addBehavior(itemBehaviour)
        }
        
        UIView.animateWithDuration(Const.Size.AnimationDuration, animations: {
            self.alpha = Const.Size.Alpha00
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
            })
    }
    
    private func dismissCard(card : UIView, swipeDir: SwipeDirection){
        animator.removeAllBehaviors()
        
        let gravityBehaviour = UIGravityBehavior(items: [card])
        let gravityVector = (swipeDir == .Left ? Const.Size.GravityLeftVexctorTuple : Const.Size.GravityRightVexctorTuple)
        gravityBehaviour.gravityDirection = CGVectorMake(gravityVector);
        animator.addBehavior(gravityBehaviour)
      
        UIView.animateWithDuration(Const.Size.AnimationDuration, animations: {
                card.alpha = Const.Size.Alpha00
            }, completion: {
                (value: Bool) in
                card.removeFromSuperview()
                
                self.cardView = nil
                swipeDir == .Left ? self.currentIndex-- : self.currentIndex++
                self.showCard(self.currentIndex, swipeDir: swipeDir)
        })
    }

    func tap(gesture: UITapGestureRecognizer){
        if gesture.state == .Ended {
            dismissCardViewContainer()
        }
    }
    
    func pan(gesture: UIPanGestureRecognizer) {
        guard let card = cardView else { return }
        let translation = gesture.translationInView(self)
        let locationInView = gesture.locationInView(self)
        let locationInCard = gesture.locationInView(card)
//        print("translation:\(translation), locationInView:\(locationInView), locationInCard:\(locationInCard)")

        switch gesture.state {
        case .Began:
            animator.removeAllBehaviors()
            let offset = UIOffsetMake(locationInCard.x - card.bounds.midX, locationInCard.y - card.bounds.midY);
            attachmentBehavior = UIAttachmentBehavior(item: card, offsetFromCenter: offset, attachedToAnchor: locationInView)
            animator.addBehavior(attachmentBehavior)
        case .Changed:
            attachmentBehavior.anchorPoint = locationInView
//            card.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y)
            //        gesture.setTranslation(CGPointZero, inView: self)
        case .Ended:
            animator.removeAllBehaviors()
            let snapBehavior = UISnapBehavior(item: card, snapToPoint: self.center)
            animator.addBehavior(snapBehavior)
            
            if translation.x > Const.Size.SwipeTranslatioToDismissCard && currentIndex + 1 < delegat?.cardsNumber(self) {
                dismissCard(card, swipeDir: .Right)
            }
            
            if translation.x < -Const.Size.SwipeTranslatioToDismissCard && currentIndex - 1 >= 0 {
                dismissCard(card, swipeDir: .Left)
            }
        default: break
        }        
    }
    
}