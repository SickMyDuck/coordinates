//
//  ViewController.swift
//  coordinates
//
//  Created by Ruslan Sadritdinov on 14.06.2022.
//

import UIKit
import GoogleMaps

protocol MapDisplayLogic: AnyObject {
    func displayPolygons(polygonArray: [GMSPolygon])
    func displayLengthLabel(_ label: GMSMarker)
}

class MapViewController: UIViewController {
    
    //MARK: - Internal Vars
    var interactor: MapBusinessLogic?
    
    //MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // Имплементируем логику для Swift Architecture
    // ViewController -> Interactor -> Presenter -> ViewController
    private func setup(){
        let viewController = self
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        interactor.presenter = presenter
        presenter.viewController = self
        viewController.interactor = interactor

    }
    
    private var mapView: GMSMapView = {
        let cameraPosition = GMSCameraPosition(latitude: Constants.labelLatitude, longitude: Constants.labelLongitude, zoom: 1)
        return GMSMapView(frame: .zero, camera: cameraPosition)
    }()

    override func loadView() {
      mapView.delegate = self
      view = mapView
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
        
        interactor?.fetchCoordinates()
        
    }

}

//MARK: - Display Logic Implementation

extension MapViewController: MapDisplayLogic {
    
    func displayPolygons(polygonArray: [GMSPolygon]) {
        for polygon in polygonArray {
            polygon.map = mapView
        }
    }
    
    func displayLengthLabel(_ label: GMSMarker) {
        label.map = mapView
    }
    
}

//MARK: - Delegate Methods

extension MapViewController: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        DispatchQueue.main.async {
            guard let polygon = overlay as? GMSPolygon else {return}
            // Используем тернарную операцию для окрашивания полигона при нажатии
            polygon.fillColor = polygon.fillColor == .clear ? .cyan.withAlphaComponent(0.3) : .clear
        }
    }
}
