//
//  MapInteractor.swift
//  coordinates
//
//  Created by Ruslan Sadritdinov on 16.06.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MapLogic {
    func fetchCoordinates()
}

class MapInteractor {
    
    //MARK: - External Vars  
    var presenter: MapPresentationLogic?
}

extension MapInteractor: MapLogic {
    
    func fetchCoordinates() {
        
        var coordinatesArray = [[Coordinate]]()
        
        let url = Constants.coordinatesURL
        
        // Выполним реквест к URL с помощью Alamofire
        AF.request(url).responseJSON{ response in
            switch response.result {
            case .success(let value):
            
                // распарсим  JSON с помощью SwiftyJSON
                let json = JSON(value)
                
                // Вызовем рекурсивную функцию во избежание дублирования кода
                self.parseJSON(jsonObject: json["features",0,"geometry","coordinates"],
                               coordinatesArray: &coordinatesArray)
                
                // Передадим полученные данные в presenter для их обработки
                self.presenter?.presentData(coordinatesArray: coordinatesArray)
                
            case .failure(let error):
                print("Error fetching data from URL: \(error)")
            }
        }
        
     
    }
    // Для упрощения понимания кода используем inout процедуру
    func parseJSON(jsonObject: JSON, coordinatesArray: inout [[Coordinate]]) {
        for (_, element):(String, JSON) in jsonObject{
            // Проверяем элемент [0][0], т.к. координата широты и долготы находятся в массиве,
            // а список этих координат, которые составляют собой один путь,
            // находятся еще в одном массиве
            switch element[0][0].type {
            case .array:
                parseJSON(jsonObject: element, coordinatesArray: &coordinatesArray)
            case .number:
                coordinatesArray.append(newCoordinateArray(jsonObject: element))
            default:
                print ("Unknown type while parsing JSON")
            }
        }
    }
        
        func newCoordinateArray(jsonObject: JSON) -> [Coordinate]{
            var coordinateArray = [Coordinate]()
            for (_, jsonObject):(String, JSON) in jsonObject{
                //  Для временного хранения координат создали структуру Coordinates
                coordinateArray.append(Coordinate(withLatitude: jsonObject[1].doubleValue,
                                                  longitude: jsonObject[0].doubleValue))
            }
            return coordinateArray
        }
}
