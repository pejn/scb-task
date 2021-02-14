//
//  MoviesListViewModelTests.swift
//  scb-recruitment-taskTests
//
//  Created by Konrad Siemczyk on 06/02/2021.
//

@testable import scb_recruitment_task
import XCTest

final class MoviesListViewModelTests: XCTestCase {
    func testLoadingState() {
        let sut = MoviesListViewModel(apiService: ApiServiceStub())
        
        if case .loading = sut.result.value {
            XCTFail("Incorrect initial state")
        }
        
        sut.search(with: "title")
        
        let loadingExpectation = XCTestExpectation(description: "Expect for loading state")
        sut.result.bind { result in
            if case .loading = result {
                loadingExpectation.fulfill()
            }
        }
        
        wait(for: [loadingExpectation], timeout: 2)
    }
    
    
    func testFailureState() {
        let sut = MoviesListViewModel(apiService: ApiServiceStub())
        sut.search(with: "error")
        
        let expectation = XCTestExpectation(description: "Expect an error")
        
        sut.result.bind { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchResults() {
        let sut = MoviesListViewModel(apiService: ApiServiceStub())
        
        XCTAssertTrue(sut.model.isEmpty)
        
        sut.search(with: "title")
        
        let moviesExpectation = XCTestExpectation(description: "Expect for new movies")
        sut.result.bind { result in
            if case .success = result {
                moviesExpectation.fulfill()
                XCTAssertFalse(sut.model.isEmpty)
            }
        }
        
        wait(for: [moviesExpectation], timeout: 2)
    }
    
    func testLoadingMore() {
        let sut = MoviesListViewModel(apiService: ApiServiceStub())
        sut.search(with: "title")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            sut.loadMore()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                sut.loadMore()
            })
        })
        
        let expectation = XCTestExpectation(description: "Expect to receive results on each load")
        expectation.expectedFulfillmentCount = 3
        
        let modelSizeExpectation1 = XCTestExpectation(description: "Expect data source collection to be equal inserted data once")
        let modelSizeExpectation2 = XCTestExpectation(description: "Expect data source collection to be larger than inserted data twice")
        modelSizeExpectation2.expectedFulfillmentCount = 2
        
        sut.result.bind { result in
            if case .success(let items) = result {
                expectation.fulfill()
                if items.count == sut.model.count {
                    modelSizeExpectation1.fulfill()
                }
                if items.count < sut.model.count {
                    modelSizeExpectation2.fulfill()
                }
            }
        }
        
        wait(for: [expectation, modelSizeExpectation1, modelSizeExpectation2], timeout: 5)
    }
}
