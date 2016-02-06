//
//  CardView.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 30.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

import UIKit

class CardView : UIView {
    // MARK: - Model
    var verb : Verb? {
        didSet {
            updateLabelsText()
        }
    }
    
    private let baseFormLabel : UILabel
    private let pastTenseLabel : UILabel
    private let pastParticipleLabel : UILabel
    
    override init(frame: CGRect) {
        baseFormLabel = UILabel()
        pastTenseLabel = UILabel()
        pastParticipleLabel = UILabel()
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLabelsText(){
        baseFormLabel.text = verb?.getBaseForm()
        pastTenseLabel.text = verb?.getPastTense()
        pastParticipleLabel.text = verb?.getPastParticiple()
    }
    
    private func configureView(){
        self.backgroundColor = Const.Color.DarkOrange
        self.layer.cornerRadius = Const.Size.CornerRadius
        
        let baseFormBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/3))
        baseFormBackgroundView.backgroundColor = UIColor.whiteColor()
        self.addSubview(baseFormBackgroundView)
        
        baseFormLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        baseFormLabel.textColor = UIColor.blackColor()
        baseFormLabel.textAlignment = .Center
        baseFormLabel.adjustsFontSizeToFitWidth = true
        baseFormLabel.minimumScaleFactor = Const.Size.MinimumFontScaleFactor
        baseFormLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/3)
        baseFormBackgroundView.addSubview(baseFormLabel)
        
        let pastTenseBackgroundView = UIView(frame: CGRect(x: 0, y: baseFormBackgroundView.frame.maxY, width: self.frame.width, height: self.frame.height/3))
        pastTenseBackgroundView.backgroundColor = UIColor.whiteColor()
        pastTenseBackgroundView.alpha = Const.Size.Alpha05
        self.addSubview(pastTenseBackgroundView)
        
        pastTenseLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        pastTenseLabel.textColor = Const.Color.DarkerGray //UIColor.grayColor()
        pastTenseLabel.textAlignment = .Center
        pastTenseLabel.adjustsFontSizeToFitWidth = true
        pastTenseLabel.minimumScaleFactor = Const.Size.MinimumFontScaleFactor
        pastTenseLabel.frame = baseFormLabel.frame
        pastTenseBackgroundView.addSubview(pastTenseLabel)
        
        
        pastParticipleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        pastParticipleLabel.textColor = UIColor.whiteColor()
        pastParticipleLabel.textAlignment = .Center
        pastParticipleLabel.adjustsFontSizeToFitWidth = true
        pastParticipleLabel.minimumScaleFactor = Const.Size.MinimumFontScaleFactor
        pastParticipleLabel.frame = CGRect(x: 0, y: pastTenseBackgroundView.frame.maxY, width: self.frame.width, height: self.frame.height/3)
        self.addSubview(pastParticipleLabel)
    }
    
}
