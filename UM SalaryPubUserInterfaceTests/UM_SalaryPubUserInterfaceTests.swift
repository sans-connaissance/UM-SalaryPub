//
//  UM_SalaryPubUserInterfaceTests.swift
//  UM SalaryPubUserInterfaceTests
//
//  Created by David Malicke on 6/23/22.
//

import XCTest

class when_user_navigates_to_personListView: XCTestCase {
    
    func test_default_personList_should_appear() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let peopleButton = app.buttons["homeScreenPeopleButton"]
        peopleButton.tap()
        
        let peopleList = app.tables["personListView"]
        XCTAssertTrue(peopleList.isEnabled)
    }
}
