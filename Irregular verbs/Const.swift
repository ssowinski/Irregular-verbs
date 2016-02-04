//
//  Constants.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 26.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//
import UIKit

struct Const {
    
    struct String {
        //WordsListViewController
        static let VCTitle = "Irregulars Verbs"
        static let CellReusedIdentifier = "CellReusedIdentifier"
        static let ShuffleBarButtonImg = "BarButtShuffle"
        static let SortBarButtonImg = "BarButtSort"
        
        //VerbsTableViewCell
        static let SpeakButtonImg = "ButtSpeaker"
        static let ShowMoreButtonImg = "ButtShowMore"
        static let SeparatorLabelText = " \u{2022} "
    }
    
    struct Size {
        static let CardWidth: CGFloat = 250
        static let CardHeight: CGFloat = 250
        static let EstimatedRowHeight: CGFloat = 100
        
        //VerbsTableViewCell
        static let ButtonHeightScaleFactor : CGFloat = 0.8
        static let MinimumFontScaleFactor : CGFloat = 0.5
        
        //Single Card View
        static let CornerRadius : CGFloat = 30
        static let AnimationDuration = 0.3
        
        //CardViewContainer
        static let CardBackgroundAlpha05 : CGFloat = 0.6
        static let Alpha00 : CGFloat = 0.0
        static let Alpha05 : CGFloat = 0.5
        static let GravityVexctorTuple : (CGFloat, CGFloat) = (0.0, 10.0)
        static let SwipeTranslatioToDismissCard : CGFloat = 150

    }
    
    struct Color {
        static let Blue = UIColor(red:0.45, green:0.69, blue:0.68, alpha:1.0) //WordListVC View background
        static let DarkBlue = UIColor(red:0.45, green:0.75, blue:0.75, alpha:1.0) //SingleCardView
        static let Gray = UIColor(red:0.573, green: 0.282, blue: 0.024, alpha:1.0) //speakButton & showMoreButton background
        static let DarkGray = UIColor(red:0.33, green:0.33, blue:0.32, alpha:1.0) //cell contentView & selectedBackgroundView background
        static let DarkerGray = UIColor(red:0.20, green:0.22, blue:0.22, alpha:1.0) //cell containerView background
        static let DarkestGray = UIColor(red:0.1, green:0.1, blue:0.1, alpha:1.0) //PastTenseLabel
        static let DarkOrange = UIColor(red:0.85, green:0.52, blue:0.23, alpha:1.0)//cell selected containerView background
    }
}


