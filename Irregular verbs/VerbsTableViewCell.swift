//
//  VerbsTableViewCell.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 02.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

import UIKit

class VerbsTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    private struct Const {
        static let Title = "Irregulars Verbs"
        static let CellReusedIdentifier = "CellReusedIdentifier"
        static let ShuffleBarButtonTitle = "Shuffle"
        static let SeparatorLabelText = " \u{2022} "
        static let Alpha01 : CGFloat = 0.1
        static let Alpha1 : CGFloat = 1.0
        
        static let ColorDarkBlue = UIColor(red:0.33, green:0.55, blue:0.54, alpha:1.0) //#558C89
        static let ColorBlue = UIColor(red:0.45, green:0.69, blue:0.68, alpha:1.0)    //#74AFAD
        static let ColorDarkOrange = UIColor(red:0.85, green:0.52, blue:0.23, alpha:1.0)//#D9853B
        static let ColorGray = UIColor(red:0.93, green:0.93, blue:0.92, alpha:1.0)//#ECECEA
        static let ColorDarkGray = UIColor(red:0.33, green:0.33, blue:0.32, alpha:1.0)
        static let ColorDarkerGray = UIColor(red:0.20, green:0.22, blue:0.22, alpha:1.0)
        static let ColorDarkerGray2 = UIColor(red:0.1, green:0.1, blue:0.1, alpha:1.0)
    }
    
    // MARK: - Model
    var verb : Verb? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - declaration and preparing UI
    private let baseFormLabel = UILabel()
    private let pastTenseLabel = UILabel()
    private let pastParticipleLabel = UILabel()
    private let separatorLabel = UILabel()
    private let containerView = UIView()
    
    func updateUI(){
        baseFormLabel.text = verb?.getBaseForm()
        pastTenseLabel.text =  verb?.getPastTense()
        pastParticipleLabel.text = verb?.getPastParticiple()
    }
    
    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Const.ColorDarkGray
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = Const.ColorDarkGray
        
        containerView.backgroundColor = Const.ColorDarkerGray
     
        baseFormLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        pastTenseLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        separatorLabel.font = pastTenseLabel.font
        pastParticipleLabel.font = pastTenseLabel.font
        separatorLabel.text = Const.SeparatorLabelText
        baseFormLabel.textColor = UIColor.whiteColor()
        pastTenseLabel.textColor = Const.ColorDarkerGray2
        separatorLabel.textColor = pastTenseLabel.textColor
        pastParticipleLabel.textColor = pastTenseLabel.textColor
        pastTenseLabel.textAlignment = .Right
        
        contentView.addSubview(containerView)
        containerView.addSubview(baseFormLabel)
        containerView.addSubview(pastTenseLabel)
        containerView.addSubview(separatorLabel)
        containerView.addSubview(pastParticipleLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        baseFormLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        pastTenseLabel.translatesAutoresizingMaskIntoConstraints = false
        pastParticipleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            
            containerView.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
            containerView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
            containerView.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
            
            baseFormLabel.topAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.topAnchor),
            baseFormLabel.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor),
            
            separatorLabel.topAnchor.constraintEqualToAnchor(baseFormLabel.bottomAnchor),
            separatorLabel.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor),
            
            pastTenseLabel.topAnchor.constraintEqualToAnchor(baseFormLabel.bottomAnchor),
            pastTenseLabel.leadingAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.leadingAnchor),
            pastTenseLabel.trailingAnchor.constraintEqualToAnchor(separatorLabel.leadingAnchor),
            pastTenseLabel.bottomAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.bottomAnchor),

            pastParticipleLabel.topAnchor.constraintEqualToAnchor(baseFormLabel.bottomAnchor),
            pastParticipleLabel.leadingAnchor.constraintEqualToAnchor(separatorLabel.trailingAnchor ),
            pastParticipleLabel.trailingAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.trailingAnchor),
            pastParticipleLabel.bottomAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        if selected {
            UIView.animateWithDuration(0.5, animations: {
                self.containerView.backgroundColor = Const.ColorDarkOrange
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.bounds.height/2
    }
}
