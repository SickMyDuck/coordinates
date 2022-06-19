//
//  Coordinate.swift
//  coordinates
//
//  Created by Ruslan Sadritdinov on 17.06.2022.
//

import Foundation

struct   Coordinate {
    var latitude: Double
    var longitude: Double
    
    init(withLatitude: Double, longitude: Double){
        self.latitude = withLatitude
        self.longitude = longitude
    }
}
