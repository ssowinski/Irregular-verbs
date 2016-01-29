//
//  VerbService.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 25.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//


class VerbService {
    func getVerbs(completionHandler: [Verb] -> Void) {
        // prepared get verbs asynchronously useing e.g. alamofire
        // for this example result is hard code
        let result = [
            Verb(baseForm: "be", pastTense: "was/were", pastParticiple: "been"),
            Verb(baseForm: "begin", pastTense: "began", pastParticiple: "begun"),
            Verb(baseForm: "break", pastTense: "broke", pastParticiple: "broken"),
            Verb(baseForm: "bring", pastTense: "brought", pastParticiple: "brought"),
            Verb(baseForm: "buy", pastTense: "bought", pastParticiple: "bought"),
            Verb(baseForm: "build", pastTense: "built", pastParticiple: "built"),
            Verb(baseForm: "choose", pastTense: "chose", pastParticiple: "chosen"),
            Verb(baseForm: "come", pastTense: "came", pastParticiple: "come"),
            Verb(baseForm: "cost", pastTense: "cost", pastParticiple: "cost"),
            Verb(baseForm: "cut", pastTense: "cut", pastParticiple: "cut"),
            Verb(baseForm: "do", pastTense: "did", pastParticiple: "done"),
            Verb(baseForm: "draw", pastTense: "drew", pastParticiple: "drawn"),
            Verb(baseForm: "drive", pastTense: "drove", pastParticiple: "driven"),
            Verb(baseForm: "eat", pastTense: "ate", pastParticiple: "eaten"),
            Verb(baseForm: "feel", pastTense: "felt", pastParticiple: "felt"),
            Verb(baseForm: "find", pastTense: "found", pastParticiple: "found"),
            Verb(baseForm: "get", pastTense: "got", pastParticiple: "got"),
            Verb(baseForm: "give", pastTense: "gave", pastParticiple: "given"),
            Verb(baseForm: "go", pastTense: "went", pastParticiple: "gone"),
            Verb(baseForm: "have", pastTense: "had", pastParticiple: "had"),
            Verb(baseForm: "hear", pastTense: "heard", pastParticiple: "heard"),
            Verb(baseForm: "hold", pastTense: "held", pastParticiple: "held"),
            Verb(baseForm: "keep", pastTense: "kept", pastParticiple: "kept"),
            Verb(baseForm: "know", pastTense: "knew", pastParticiple: "known"),
            Verb(baseForm: "leave", pastTense: "left", pastParticiple: "left"),
            Verb(baseForm: "lead", pastTense: "led", pastParticiple: "led"),
            Verb(baseForm: "let", pastTense: "let", pastParticiple: "let"),
            Verb(baseForm: "lie", pastTense: "lay", pastParticiple: "lain"),
            Verb(baseForm: "lose", pastTense: "lost", pastParticiple: "lost"),
            Verb(baseForm: "make", pastTense: "made", pastParticiple: "made"),
            Verb(baseForm: "mean", pastTense: "meant", pastParticiple: "meant"),
            Verb(baseForm: "meet", pastTense: "met", pastParticiple: "met"),
            Verb(baseForm: "pay", pastTense: "paid", pastParticiple: "paid"),
            Verb(baseForm: "put", pastTense: "put", pastParticiple: "put"),
            Verb(baseForm: "run", pastTense: "ran", pastParticiple: "run"),
            Verb(baseForm: "say", pastTense: "said", pastParticiple: "said"),
            Verb(baseForm: "see", pastTense: "saw", pastParticiple: "seen"),
            Verb(baseForm: "sell", pastTense: "sold", pastParticiple: "sold"),
            Verb(baseForm: "send", pastTense: "sent", pastParticiple: "sent"),
            Verb(baseForm: "set", pastTense: "set", pastParticiple: "set"),
            Verb(baseForm: "sit", pastTense: "sat", pastParticiple: "sat"),
            Verb(baseForm: "speak", pastTense: "spoke", pastParticiple: "spoken"),
            Verb(baseForm: "spend", pastTense: "spent", pastParticiple: "spent"),
            Verb(baseForm: "stand", pastTense: "stood", pastParticiple: "stood"),
            Verb(baseForm: "take", pastTense: "took", pastParticiple: "taken"),
            Verb(baseForm: "teach", pastTense: "taught", pastParticiple: "taught"),
            Verb(baseForm: "tell", pastTense: "told", pastParticiple: "told"),
            Verb(baseForm: "think", pastTense: "thought", pastParticiple: "thought"),
            Verb(baseForm: "understand", pastTense: "understood", pastParticiple: "understood"),
            Verb(baseForm: "wear", pastTense: "wore", pastParticiple: "worn"),
            Verb(baseForm: "win", pastTense: "won", pastParticiple: "won"),
            Verb(baseForm: "write", pastTense: "wrote", pastParticiple: "written")
        ]
        completionHandler(result)
    }
}
