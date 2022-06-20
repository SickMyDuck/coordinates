//
//  MapPresentationLogicSpy.swift
//  CoordinatesTests
//
//  Created by Ruslan Sadritdinov on 20.06.2022.
//

import Foundation
@testable import coordinates

final class MapPresentationLogicSpy: MapPresentationLogic {

  // MARK: - Public Properties
  
  private(set) var isCalledPresentData = false
  
  // MARK: - Public Methods
  
    func presentData(coordinatesArray: [[Coordinate]]) {
        isCalledPresentData = true
  }
}

