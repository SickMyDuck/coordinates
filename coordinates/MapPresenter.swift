//
//  MapPresenter.swift
//  coordinates
//
//  Created by Ruslan Sadritdinov on 16.06.2022.
//

import UIKit
import GoogleMaps

protocol MapPresentationLogic {
    
    func presentData(coordinatesArray: [[Coordinate]])
}

class MapPresenter {
    
    var totalLength : Double = 0.0
    weak var viewController: MapDisplayLogic?
    
}

//MARK: - Presentation Logic

extension MapPresenter: MapPresentationLogic {
    func presentData(coordinatesArray: [[Coordinate]]) {
        
        var pathArray : [GMSMutablePath] = pathArray(from: coordinatesArray)
        // Сортируем массив по убыванию для дальшейшего соединения полуострова по 180 меридиану
        pathArray.sort{$0.count() > $1.count()}
        
        pathArray = unitePolygonsOn180Meridian(pathArray: pathArray)
        
        presentPolygons(pathArray: pathArray)
        
        presentLengthLabel()
        
    }
    
    func presentPolygons(pathArray: [GMSMutablePath]) {
        
        var polygonArray: [GMSPolygon] = []
        
        for path in pathArray {
                
            // Для каждого пути создадим Polygon, чтобы в будущем его
            // можно было раскрасить при нажатии
            let polygon = GMSPolygon(path: path)
            polygon.isTappable = true
            polygon.zIndex = 0
            polygon.fillColor = .clear
            polygon.strokeColor = UIColor.blue
            polygon.strokeWidth = 1.0
            
            polygonArray.append(polygon)
            
            totalLength += path.length(of: .geodesic)

        }
        
        // Обработанные данные передаем во ViewController для их отображения
        viewController?.displayPolygons(polygonArray: polygonArray)
        

    }
    
    func presentLengthLabel() {
        let labelMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: Constants.labelLatitude, longitude: Constants.labelLongitude))
        let label = UILabel()
        let roundedTotalLengthInKilometers = Double(round(100 * (totalLength / 1000)) / 100)
        label.text = "Total borders length: \(roundedTotalLengthInKilometers) km"
        label.sizeToFit()
        label.textColor = UIColor.red
        labelMarker.iconView = label
        
        viewController?.displayLengthLabel(labelMarker)
    }
    
    
    func pathArray(from coordinatesArray: [[Coordinate]]) -> [GMSMutablePath] {
        var pathArray = [GMSMutablePath]()
        for coordinateArray in coordinatesArray {
            let path = GMSMutablePath()
            for coordinate in coordinateArray{
                path.add(CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                longitude: coordinate.longitude))
            }
            pathArray.append(path)
        }
        return pathArray
    }
    
    func unitePolygonsOn180Meridian(pathArray: [GMSMutablePath]) -> [GMSMutablePath] {
        // т.к. нужно объединить по 180 меридиану 2 самых больших области,
        // то установим отбор только по первому элементу массива
        guard pathArray.count > 0 else {return []}
        
        let path = pathArray[0]
        
        var iterator : UInt = 0
    
        for i in 0..<path.count() {
            // если координата в пути равна 180 меридиану, удаляем
            if path.coordinate(at: i).longitude == Constants.meridianLongitude {
                
                path.removeCoordinate(at: i)
                // на место первой найденной координаты, которую удалили,
                // позже поместим все координаты второго пути,
                // чтобы путь отрисовался корректно
                if iterator == 0 {
                    iterator = i
                }
            }
        }

        // Добавим координаты полуострова в самый большой путь
        for j in 0..<pathArray[1].count() {
            path.insert(pathArray[1].coordinate(at: j), at: iterator)
        }
        // Удалим все координаты полуострова, т.к. мы их уже добавили в первый путь
        pathArray[1].removeAllCoordinates()
        
        return pathArray
    }
    
    
    
}
