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
        static let GravityDownVexctorTuple : (CGFloat, CGFloat) = (0.0, 10.0)
        static let GravityLeftVexctorTuple : (CGFloat, CGFloat) = (-10.0, 0.0)
        static let GravityRightVexctorTuple : (CGFloat, CGFloat) = (10.0, 0.0)
        static let SwipeTranslatioToDismissCard : CGFloat = 100
    }
    
    struct Color {
        static let Blue = UIColor(rgb: 0x74AFAD) //WordListVC View background
        static let Gray = UIColor(rgb: 0x924706) //speakButton & showMoreButton background
        static let DarkGray = UIColor(rgb: 0x545451) //cell contentView & selectedBackgroundView background
        static let DarkerGray = UIColor(rgb: 0x333838) //cell containerView background
        static let DarkestGray = UIColor(rgb: 0x191919) //PastTenseLabel
        static let DarkOrange = UIColor(rgb: 0xD8843A) //cell selected containerView background
    }
}


