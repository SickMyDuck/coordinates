//
//  MapDisplayLogicSpy.swift
//  CoordinatesTests
//
//  Created by Ruslan Sadritdinov on 20.06.2022.
//

import Foundation
import GoogleMaps
@testable import coordinates

final class MapDisplayLogicSpy: MapDisplayLogic {

  // MARK: - Public Properties
  
  private(set) var isCalledDisplayPolygons = false
    private(set) var isCalledDisplayLengthLabel = false
  
  // MARK: - Public Methods
  
  func displayPolygons(polygonArray: [GMSPolygon]) {
    isCalledDisplayPolygons = true
  }
    
    func displayLengthLabel(_ label: GMSMarker) {
      isCalledDisplayLengthLabel = true
    }
}
