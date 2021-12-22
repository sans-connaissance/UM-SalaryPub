//
//  UM_SalaryPubUITests.swift
//  UM SalaryPubUITests
//
//  Created by David Malicke on 12/21/21.
//

import XCTest

class setup_tests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
}

class people_search: setup_tests {
    
    func select_random_person_from_personViewList() {
        let peopleButton = app.links["peopleSearch"]
        peopleButton.tap()
        
        let searchText = app.textFields["searchText"]
        searchText.typeText("smith")
        
        let personList = app.tables["personList"]
        XCTAssertTrue(personList.exists)
        
    }
}
