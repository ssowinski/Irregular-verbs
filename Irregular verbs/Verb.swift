//
//  Verb.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 25.01.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

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

extension Verb: Equatable { }
func == (lhs: Verb, rhs: Verb) -> Bool {
    return lhs.baseForm == rhs.baseForm && lhs.pastTense == rhs.pastTense && lhs.pastParticiple == rhs.pastParticiple
}
