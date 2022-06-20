//
//  MapPresenterTests.swift
//  CoordinatesTests
//
//  Created by Ruslan Sadritdinov on 20.06.2022.
//

import XCTest
@testable import coordinates

final class MapPresenterTests: XCTestCase {
  
  // MARK: - Private Properties
  
  private var sut: MapPresenter!
  private var viewController: MapDisplayLogicSpy!
  
  // MARK: - Lifecycle
  
  override func setUp() {
    super.setUp()
    
    let mapPresenter = MapPresenter()
    let mapViewController = MapDisplayLogicSpy()
    
    mapPresenter.viewController = mapViewController
    
    sut = mapPresenter
    viewController = mapViewController
  }
  
  override func tearDown() {
    sut = nil
    viewController = nil
    
    super.tearDown()
  }
  
  // MARK: - Public Methods
  func testPresentData() {

    var testCoordinatesArray: [[Coordinate]] = []
    testCoordinatesArray.append([Coordinate(withLatitude: 1.0, longitude: 1.0),
                                 Coordinate(withLatitude: 2.0, longitude: 2.0),
                                 Coordinate(withLatitude: 3.0, longitude: 3.0),
                                 Coordinate(withLatitude: 4.0, longitude: 4.0)])
      testCoordinatesArray.append([Coordinate(withLatitude: -1.0, longitude: -1.0),
                                   Coordinate(withLatitude: -2.0, longitude: -2.0),
                                   Coordinate(withLatitude: -3.0, longitude: -3.0),
                                   Coordinate(withLatitude: -4.0, longitude: -4.0)])
    
    sut.presentData(coordinatesArray: testCoordinatesArray)
    
    XCTAssertTrue(viewController.isCalledDisplayPolygons, "Not started viewController.displayPolygons(:)")
      
    XCTAssertTrue(viewController.isCalledDisplayLengthLabel, "Not started viewController.displayLengthLabel(:)")
  }
}
