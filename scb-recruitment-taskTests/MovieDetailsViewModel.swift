//
//  MovieDetailsViewModel.swift
//  scb-recruitment-taskTests
//
//  Created by Konrad Siemczyk on 14/02/2021.
//

@testable import scb_recruitment_task
import XCTest

final class MovieDetailsViewModelTests: XCTestCase {
    func testLoadingState() {
        let sut = MovieDetailsViewModel(movieId: "123", apiService: ApiServiceStub())
        
        if case .loading = sut.result.value {
            XCTFail("Incorrect initial state")
        }
        
        let loadingExpectation = XCTestExpectation(description: "Expect for loading state")
        sut.result.bind { result in
            if case .loading = result {
                loadingExpectation.fulfill()
            }
        }
        
        sut.loadDetails()
        
        wait(for: [loadingExpectation], timeout: 2)
    }
    
    func testDetailsResult() {
        let sut = MovieDetailsViewModel(movieId: "123", apiService: ApiServiceStub())
        
        if case .success = sut.result.value {
            XCTFail("Incorrect initial state")
        }
        
        let expectation = XCTestExpectation(description: "Expect for details result")
        sut.result.bind { result in
            if case .success = result {
                expectation.fulfill()
            }
        }
        
        sut.loadDetails()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFailureState() {
        let sut = MovieDetailsViewModel(movieId: ApiServiceStub.errorId, apiService: ApiServiceStub())
        
        let expectation = XCTestExpectation(description: "Expect an error")
        sut.result.bind { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        
        sut.loadDetails()
        
        wait(for: [expectation], timeout: 2)
    }
}
