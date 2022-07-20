//
//  ProfilePresenterTests.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import XCTest
@testable import Twitter

class ProfilePresenterTests: XCTestCase {
    var sut: ProfilePresenter!
    var viewController: MockProfileViewController!
    
    override func setUp() {
        super.setUp()
        viewController = MockProfileViewController()
        sut = ProfilePresenter(viewController: viewController)
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }
    
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledSetupConstraints)
        XCTAssertTrue(viewController.isCalledSetupNavigation)
        XCTAssertTrue(viewController.isCalledConfigureView)
    }
    
    func test_didTapSaveButton가_요청되고_name_account가_모두_존재하면() {
        sut.didTapSaveButton(name: "Test", account: "Test")
        
        XCTAssertTrue(viewController.isCalledEndEditing)
        XCTAssertTrue(viewController.isCalledConfigureView)
        XCTAssertTrue(viewController.isCalledShowToast)
    }
    
    func test_didTapSaveButton가_요청되고_name이_존재하지_않으면() {
        sut.didTapSaveButton(name: nil, account: "Test")
        
        XCTAssertTrue(viewController.isCalledShowToast)
        XCTAssertFalse(viewController.isCalledEndEditing)
        XCTAssertFalse(viewController.isCalledConfigureView)
    }
    
    func test_didTapSaveButton가_요청되고_account가_존재하지_않으면() {
        sut.didTapSaveButton(name: "Test", account: nil)
        
        XCTAssertTrue(viewController.isCalledShowToast)
        XCTAssertFalse(viewController.isCalledEndEditing)
        XCTAssertFalse(viewController.isCalledConfigureView)
    }
    
    func test_didTapSaveButton가_요청되고_둘_다_값이_존재하지_않으면() {
        sut.didTapSaveButton(name: nil, account: nil)
        
        XCTAssertTrue(viewController.isCalledShowToast)
        XCTAssertFalse(viewController.isCalledEndEditing)
        XCTAssertFalse(viewController.isCalledConfigureView)
    }
}
