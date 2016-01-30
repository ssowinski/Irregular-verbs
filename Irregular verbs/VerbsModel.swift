//
//  VerbsModel.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 28.12.2015.
//  Copyright © 2015 Slawomir Sowinski. All rights reserved.
//

import Foundation

class VerbsModel {
    private var verbs : [Verb]
    
    init(){
        verbs = [Verb]()
    }
    
    //declartion function with default parameter values
    func fetchVerbs(verbService: VerbService = VerbService()) {
        verbService.getVerbs(){ [weak self](verbs) -> Void in
            self?.verbs = verbs
        }
    }
    
    func getVerb(i: Int) -> Verb? {
        guard i < verbs.count else { return nil }
        return verbs[i]
    }
    
    func countVerbs() -> Int {
        return verbs.count
    }
    
    func shuffleVerbs() {
        guard verbs.count > 0 else { return }
        for i in 0 ..< (verbs.count - 1) {
            let j = Int(arc4random_uniform(UInt32(verbs.count - i))) + i
            if i != j {
                swap(&verbs[i], &verbs[j])
                //You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
            }
        }
    }
    
    func resetDefaultSort() {
        //Full Closure Expression Syntax
        verbs.sortInPlace { (verb1, verb2) -> Bool in
            return verb1.getBaseForm() < verb2.getBaseForm()
        }
        
        //Closures with shorthand argument names (functionally exactly the same as above)
        //verbs.sortInPlace({$0.getBaseForm() < $1.getBaseForm()}
    }
    
}
