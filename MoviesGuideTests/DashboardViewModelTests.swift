//
//  DashboardViewModelTests.swift
//  MoviesGuideTests
//
//  Created by Irshad Qureshi on 19/10/2021.
//

import XCTest
@testable import MoviesGuide

class DashboardViewModelTests: XCTestCase {
    
    var sut: DashboardViewModelProtocol!
    var apiManagerMock: APIManagerMock!

    // MARK: Test lifecycle
    override func setUpWithError() throws {
        sut = DashboardViewModel()
        apiManagerMock = APIManagerMock()
        sut.apiManager = apiManagerMock
    }
    
    override func tearDownWithError() throws {
        sut = nil
        apiManagerMock = nil
    }
    
    // MARK: Tests
    func testApplyFilter() {
        sut.apply(filter: .popular)
        sut.apply(filter: .topRated)
        sut.apply(filter: .upcoming)
        XCTAssertTrue(apiManagerMock.isRequestApi)
    }
    
    func testGetMovieList() {
        sut.getMovieList(url: Constants.WebService.popularAPI)
        XCTAssertTrue(apiManagerMock.isRequestApi)
    }
    
    func testTableMethods() {
        let items = sut.numberOfItems()
        XCTAssertEqual(items, 0)

        let  movieModel = sut.model(for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(movieModel)
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class APIManagerMock: APIManagerProtocol {

    var isRequestApi = false
    var isCancelNetworkRequest = false

    func requestApi(apiUrl: String, params: String?, handler: @escaping (Data?, URLResponse?, Error?) -> Void){
        isRequestApi = true
    }
    func cancelNetworkRequest(){
        isCancelNetworkRequest = true
    }
    
}

