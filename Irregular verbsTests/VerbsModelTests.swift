//
//  VerbsModelTests.swift
//  Irregular verbs
//
//  Created by Slawomir Sowinski on 07.02.2016.
//  Copyright © 2016 Slawomir Sowinski. All rights reserved.
//

import XCTest
@testable import Irregular_verbs

class VerbsModelTests: XCTestCase {
    
    func testGetVerbBeforeFetchVerbs() {
        let verbsModel = VerbsModel()
        XCTAssertEqual(verbsModel.getVerb(1), nil)
    }
    
    func testGetVerbAfterFetchVerbs() {
        let verbsModel = VerbsModel()
        verbsModel.fetchVerbs()
        XCTAssertNotEqual(verbsModel.getVerb(1), nil)
    }
}
