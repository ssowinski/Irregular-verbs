//
//  CardViewContainer.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 30.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//


import UIKit

protocol CardViewContainerDelegate {
    func cardsNumber(cardViewContainer : CardViewContainer) -> Int
    func cardForIndex(cardViewContainer : CardViewContainer, index: Int) -> UIView
}

enum SwipeDirection {
    case Left
    case Right
}

class CardViewContainer: UIView {
    
    var delegat : CardViewContainerDelegate? {
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
        alphaBackground.backgroundColor = UIColor.grayColor()
        alphaBackground.alpha = Const.Size.CardBackgroundAlpha05
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
            gravityBehaviour.gravityDirection = CGVectorMake(Const.Size.GravityVexctorTuple);
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
                
                //                self.alertView = nil
            })
    }
    
    private func dismissCard(card : UIView, swipeDir: SwipeDirection){
        animator.removeAllBehaviors()
        
        let finishPointX = (swipeDir == .Left ? -card.frame.width : self.frame.width + card.frame.width)
        let finishPoint = CGPointMake(finishPointX, card.center.y)
        
        UIView.animateWithDuration(Const.Size.AnimationDuration, animations: {
                card.center = finishPoint
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
        
        print("translation:\(translation), locationInView:\(locationInView), locationInCard:\(locationInCard)")
        
        switch gesture.state {
        case .Began:
            animator.removeAllBehaviors()
        case .Changed:
            card.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y)
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
        
        //        if (cardView != nil) {
        //            let panLocationInView = gesture.locationInView(self)
        //            let panLocationInCardView = gesture.locationInView(cardView)
        //
        //            if gesture.state == UIGestureRecognizerState.Began {
        //            animator.removeAllBehaviors()
        //
        //            let offset = UIOffsetMake(panLocationInCardView.x - CGRectGetMidX(cardView!.bounds), panLocationInCardView.y - CGRectGetMidY(cardView!.bounds));
        //            attachmentBehavior = UIAttachmentBehavior(item: cardView!, offsetFromCenter: offset, attachedToAnchor: panLocationInView)
        //
        //            animator.addBehavior(attachmentBehavior)
        //        }
        //            else if gesture.state == UIGestureRecognizerState.Changed {
        //            attachmentBehavior.anchorPoint = panLocationInView
        //        }
        //            else if gesture.state == UIGestureRecognizerState.Ended {
        //            animator.removeAllBehaviors()
        //
        //            let snapBehavior = UISnapBehavior(item: cardView!, snapToPoint: self.center)
        //            animator.addBehavior(snapBehavior)
        //
        //            if gesture.translationInView(self).y > 100 {
        //                //                    dismissAlert()
        //            }
        //            }
        //        }
        
    }
    
}