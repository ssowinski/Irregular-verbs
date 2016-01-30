//
//  SpeechSynthesizer.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 30.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

import AVFoundation

class SpeechSynthesizer {
    
    private let avSpeechSynthesizer : AVSpeechSynthesizer
    
    init(){
        self.avSpeechSynthesizer = AVSpeechSynthesizer()
    }
    
    func say(sentence: String){
        avSpeechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let speechUtterance = AVSpeechUtterance(string: sentence)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        //            avSpeechSynthesizer.rate = 0.35
        //            avSpeechSynthesizer.pitchMultiplier = 0.65
        //            avSpeechSynthesizer.volume = 0.75
        avSpeechSynthesizer.speakUtterance(speechUtterance)
    }
    
}