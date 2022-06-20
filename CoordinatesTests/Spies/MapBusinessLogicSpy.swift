//
//  MapsBusinessLogicSpy.swift
//  CoordinatesTests
//
//  Created by Ruslan Sadritdinov on 19.06.2022.
//

import Foundation

import Foundation
@testable import coordinates

final class MapBusinessLogicSpy: MapBusinessLogic {
    
    
    // MARK: - Public Properties
    
    private(set) var isCalledFetchCoordinates = false
    private(set) var isCalledRetrieveCoordinates = false
    
    // MARK: - Public Methods
    
    func fetchCoordinates() {
        isCalledFetchCoordinates = true
    }
    
    func retrieveCoordinates() {
        isCalledRetrieveCoordinates = true
    }
    
}
