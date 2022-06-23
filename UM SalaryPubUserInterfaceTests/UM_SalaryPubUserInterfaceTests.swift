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

class when_user_navigates_to_titlesListView: XCTestCase {
    
    func test_default_titleList_should_appear() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleButton = app.buttons["homeScreenTitlesButton"]
        titleButton.tap()
        
        let titleList = app.tables["titleListView"]
        XCTAssertTrue(titleList.isEnabled)
    }
}

class when_user_navigates_to_departmentsListView: XCTestCase {
    
    func test_default_departmentList_should_appear() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let departmentButton = app.buttons["homeScreenDepartmentsButton"]
        departmentButton.tap()
        
        let departmentList = app.tables["departmentListView"]
        XCTAssertTrue(departmentList.isEnabled)
    }
}

class when_user_navigates_to_campusesListView: XCTestCase {
    
    func test_default_campusList_should_appear() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let campusButton = app.buttons["homeScreenCampusesButton"]
        campusButton.tap()
        
        let campusList = app.tables["campusListView"]
        XCTAssertTrue(campusList.isEnabled)
    }
}
