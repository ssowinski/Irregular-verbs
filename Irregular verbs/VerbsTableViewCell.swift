//
//  VerbsTableViewCell.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 02.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

import UIKit

protocol ButtonShowMoreDelegate: class {
    func buttonAction(cell: VerbsTableViewCell)
}


class VerbsTableViewCell: UITableViewCell {
    
    // MARK: - Model
    var verb : Verb? {
        didSet {
            updateLabelsText()
        }
    }

    weak var buttonShowMoreDelegate : ButtonShowMoreDelegate!
    
    // MARK: - Private declaration (UI & SpeechSynthesizer)
    private let baseFormLabel : UILabel
    private let pastTenseLabel : UILabel
    private let pastParticipleLabel : UILabel
    private let separatorLabel : UILabel
    private let containerView : UIView
    private let speakButton : UIButton
    private let showMoreButton : UIButton
    
    private let speechSynthesizer : SpeechSynthesizer
    
    private func updateLabelsText(){
        baseFormLabel.text = verb?.getBaseForm()
        pastTenseLabel.text =  verb?.getPastTense()
        pastParticipleLabel.text = verb?.getPastParticiple()
    }
    
    
    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        baseFormLabel = UILabel()
        pastTenseLabel = UILabel()
        pastParticipleLabel = UILabel()
        separatorLabel = UILabel()
        containerView = UIView()
        speakButton = UIButton()
        showMoreButton = UIButton()
        speechSynthesizer = SpeechSynthesizer()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutUI()
        createAndActiveConstraints()
    }
    
    // MARK - Button action
    func speakButtonAction(sender: UIButton) {
        if let str1 = verb?.getBaseForm(), let str2 = verb?.getPastTense(), let str3 = verb?.getPastParticiple() {
            speechSynthesizer.say(str1 + ", " + str2 + ", " + str3)
        }
    }
    
    func showMoreAction(sender: UIButton) {
        buttonShowMoreDelegate?.buttonAction(self)
    }
    
    // MARK: - Override methods
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        if selected {
            UIView.animateWithDuration(0.5, animations: {
                self.containerView.backgroundColor = Const.Color.DarkOrange
                self.speakButton.backgroundColor = Const.Color.Gray
                self.speakButton.hidden = false
                
                self.showMoreButton.backgroundColor = Const.Color.Gray
                self.showMoreButton.hidden = false
            })
            //             speakButton.backgroundColor = Con.ColorDarkBlue
        } else {
            speakButton.hidden = true
            showMoreButton.hidden = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.bounds.height/2
        speakButton.layer.cornerRadius = speakButton.bounds.height/2
        showMoreButton.layer.cornerRadius = showMoreButton.bounds.height/2
    }
    
    // MARK: - Preparing UI 
    private func layoutUI(){
        contentView.backgroundColor = Const.Color.DarkGray
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = Const.Color.DarkGray
        
        containerView.backgroundColor = Const.Color.DarkerGray
        speakButton.setImage(UIImage(named: Const.String.SpeakButtonImg), forState: UIControlState.Normal)
        speakButton.addTarget(self, action: "speakButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        speakButton.hidden = true
        
        showMoreButton.setImage(UIImage(named: Const.String.ShowMoreButtonImg), forState: .Normal)
        showMoreButton.addTarget(self, action: "showMoreAction:", forControlEvents: UIControlEvents.TouchUpInside)
        showMoreButton.hidden = true
        
        //        speakButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        //        speakButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
        
        baseFormLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        pastTenseLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        separatorLabel.font = pastTenseLabel.font
        pastParticipleLabel.font = pastTenseLabel.font
        separatorLabel.text = Const.String.SeparatorLabelText
        baseFormLabel.textColor = UIColor.whiteColor()
        pastTenseLabel.textColor = Const.Color.DarkestGray
        separatorLabel.textColor = pastTenseLabel.textColor
        pastParticipleLabel.textColor = pastTenseLabel.textColor
        pastTenseLabel.textAlignment = .Right
        pastParticipleLabel.adjustsFontSizeToFitWidth = true
        pastParticipleLabel.minimumScaleFactor = Const.Size.MinimumFontScaleFactor
        pastTenseLabel.adjustsFontSizeToFitWidth = true
        pastTenseLabel.minimumScaleFactor = Const.Size.MinimumFontScaleFactor
        
        contentView.addSubview(containerView)
        containerView.addSubview(speakButton)
        containerView.addSubview(showMoreButton)
        containerView.addSubview(baseFormLabel)
        containerView.addSubview(pastTenseLabel)
        containerView.addSubview(separatorLabel)
        containerView.addSubview(pastParticipleLabel)
    }
    
    private func createAndActiveConstraints(){        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false
        baseFormLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        pastTenseLabel.translatesAutoresizingMaskIntoConstraints = false
        pastParticipleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activateConstraints([
            containerView.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
            containerView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
            containerView.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
            
            speakButton.heightAnchor.constraintEqualToAnchor(containerView.heightAnchor, multiplier: Const.Size.ButtonHeightScaleFactor),
            speakButton.widthAnchor.constraintEqualToAnchor(speakButton.heightAnchor),
            speakButton.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor),
            speakButton.trailingAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.trailingAnchor),
            
            showMoreButton.heightAnchor.constraintEqualToAnchor(speakButton.heightAnchor),
            showMoreButton.widthAnchor.constraintEqualToAnchor(speakButton.heightAnchor),
            showMoreButton.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor),
            showMoreButton.leadingAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.leadingAnchor),
            
            baseFormLabel.topAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.topAnchor),
            baseFormLabel.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor),
            
            separatorLabel.topAnchor.constraintEqualToAnchor(baseFormLabel.bottomAnchor),
            separatorLabel.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor),
            
            pastTenseLabel.topAnchor.constraintEqualToAnchor(baseFormLabel.bottomAnchor),
            pastTenseLabel.leadingAnchor.constraintEqualToAnchor(showMoreButton.trailingAnchor),
            pastTenseLabel.trailingAnchor.constraintEqualToAnchor(separatorLabel.leadingAnchor),
            pastTenseLabel.bottomAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.bottomAnchor),
            
            pastParticipleLabel.topAnchor.constraintEqualToAnchor(baseFormLabel.bottomAnchor),
            pastParticipleLabel.leadingAnchor.constraintEqualToAnchor(separatorLabel.trailingAnchor ),
            pastParticipleLabel.trailingAnchor.constraintEqualToAnchor(speakButton.leadingAnchor),
            pastParticipleLabel.bottomAnchor.constraintEqualToAnchor(containerView.layoutMarginsGuide.bottomAnchor)
            ])
    }
}
