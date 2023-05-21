//
//  ListCompaniesPresenterTest.swift
//  MobintTests
//
//  Created by ramil on 20.05.2023.
//

import XCTest
@testable import MobintTestTask

final class ListCompaniesPresenterTest: XCTestCase {
    
    //MARK: - Testable properties
    var networkFetcher: MockNetworkFetcher!
    var imageService: MockImageService!
    var sut: ListCompaniesPresenter!
    var view: MockListCompaniesView!
    
    //MARK: - SetUp
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        networkFetcher = MockNetworkFetcher()
        imageService = MockImageService()
        view = MockListCompaniesView()
        sut = ListCompaniesPresenter(view: view,
                                     networkFetcher: networkFetcher, imageService: imageService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        view = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Testable methods
    func testThatDependenciesNotNil() {
        //Then
        XCTAssertNotNil(sut.view)
        XCTAssertNotNil(sut.networkFetcher)
        XCTAssertNotNil(sut.imageService)
    }
    
    func testShouldReturnZeroCount_WhenDataIsEmpty() {
        //Given
        let expectedCompaniesCount = 0
        //When
        let testCompaniesCount = sut.getCompaniesCount()
        //Then
        XCTAssertEqual(expectedCompaniesCount, testCompaniesCount,"Expected count should be zero")
    }
    
    func testShouldReturnNil_WhenCompaniesIsEmpty() {
        //Given
        let indexPath = IndexPath(row: 0, section: 0)
        //When
        let testCompanyForRow = sut.getCompanyForRow(indexPath: indexPath)
        //Then
        XCTAssertNil(testCompanyForRow)
    }
    
    func testShouldTriggerImageServiceMethod() {
        
        //Given
        let testUrl = "Foo"
        let indexPath = IndexPath(row: 0, section: 0)
        let expectetion = expectation(description: "loadImage")
        
        //When
        sut.loadImage(url: testUrl, indexPath: indexPath) { testImage in
            expectetion.fulfill()
        }
        wait(for: [expectetion], timeout: 3)
        
        //Then
        XCTAssertTrue(imageService.loadImageExecutionCount == 1, "Expected execution count should be the one")
    }
    
    func testShouldTriggerLoadInitialFunction() {
        //When
        sut.loadInitialCompanies()
        //Then
        XCTAssertTrue(networkFetcher.fetchCompaniesExecutionCount == 1, "Expected execution count should be the one")
    }
    
    func testShouldTriggerLoadNextFunction() {
        //When
        sut.loadNextCompanies()
        //Then
        XCTAssertTrue(networkFetcher.fetchCompaniesExecutionCount == 1, "Expected execution count should be the one")
    }
}
