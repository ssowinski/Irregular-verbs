//
//  VerbsModel.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 28.12.2015.
//  Copyright © 2015 Slawomir Sowinski. All rights reserved.
//

import Foundation

 struct Verb {
    private let baseForm : String
    private let pastTense : String
    private let pastParticiple : String
    
    init(baseForm : String, pastTense : String, pastParticiple : String){
        self.baseForm = baseForm
        self.pastTense = pastTense
        self.pastParticiple = pastParticiple
    }
    
    func getBaseForm() -> String {
        return baseForm
    }
    
    func getPastTense() -> String {
        return pastTense
    }
    
    func getPastParticiple() -> String {
        return pastParticiple
    }
}

class VerbsModel {
    private var verbs = [Verb]()
    
    init(){
        verbs.append(Verb(baseForm: "be", pastTense: "was/were", pastParticiple: "been"))
        verbs.append(Verb(baseForm: "begin", pastTense: "began", pastParticiple: "begun"))
        verbs.append(Verb(baseForm: "break", pastTense: "broke", pastParticiple: "broken"))
        verbs.append(Verb(baseForm: "bring", pastTense: "brought", pastParticiple: "brought"))
        verbs.append(Verb(baseForm: "buy", pastTense: "bought", pastParticiple: "bought"))
        verbs.append(Verb(baseForm: "build", pastTense: "built", pastParticiple: "built"))
        verbs.append(Verb(baseForm: "choose", pastTense: "chose", pastParticiple: "chosen"))
        verbs.append(Verb(baseForm: "come", pastTense: "came", pastParticiple: "come"))
        verbs.append(Verb(baseForm: "cost", pastTense: "cost", pastParticiple: "cost"))
        verbs.append(Verb(baseForm: "cut", pastTense: "cut", pastParticiple: "cut"))
        verbs.append(Verb(baseForm: "do", pastTense: "did", pastParticiple: "done"))
        verbs.append(Verb(baseForm: "draw", pastTense: "drew", pastParticiple: "drawn"))
        verbs.append(Verb(baseForm: "drive", pastTense: "drove", pastParticiple: "driven"))
        verbs.append(Verb(baseForm: "eat", pastTense: "ate", pastParticiple: "eaten"))
        verbs.append(Verb(baseForm: "feel", pastTense: "felt", pastParticiple: "felt"))
        verbs.append(Verb(baseForm: "find", pastTense: "found", pastParticiple: "found"))
        verbs.append(Verb(baseForm: "get", pastTense: "got", pastParticiple: "got"))
        verbs.append(Verb(baseForm: "give", pastTense: "gave", pastParticiple: "given"))
    }
    
    func getVerb(i: Int) -> Verb? {
        guard i < verbs.count else { return nil }
        return verbs[i]
    }
    
    func countVerbs() -> Int {
        return verbs.count
    }
}


//http://learnenglish.britishcouncil.org/en/english-grammar/verbs/irregular-verbs
