//
//  MapInteractorTests.swift
//  CoordinatesTests
//
//  Created by Ruslan Sadritdinov on 20.06.2022.
//
import XCTest
@testable import coordinates

final class MapInteractorTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: MapInteractor!
    private var presenter: MapPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let mapInteractor = MapInteractor()
        let mapPresenter = MapPresentationLogicSpy()
        
        sut = mapInteractor
        presenter = mapPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        presenter = nil
    }
    
    // MARK: - Public Methods
    
    func testFetchCoordinates() {
        
        sut.fetchCoordinates()
        
        var result: [[Coordinate]] = [[]]
        let expectation = self.expectation(description: "Waiting for retrieveCoordinates Call")
        
        sut.retrieveCoordinates { testCoordinatesArray in
            
            result = testCoordinatesArray
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10){ error in
            XCTAssertNil(error)
            
            XCTAssertTrue(self.presenter.isCalledPresentData, "Not started presenter.presentData()")
            
            XCTAssertFalse(result.isEmpty, "Coordinates array is empty")
            
        }
        

        
    }
}
