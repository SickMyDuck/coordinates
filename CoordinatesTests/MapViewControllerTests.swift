//
//  MapViewControllerTests.swift
//  CoordinatesTests
//
//  Created by Ruslan Sadritdinov on 19.06.2022.
//

import XCTest
@testable import coordinates

final class MapViewControllerTests: XCTestCase {
    
    //MARK: - Private Properties
    private var sut: MapViewController!
    private var interactor: MapBusinessLogicSpy!
    private var window: UIWindow!
    
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let mainWindow = UIWindow()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        
        let mapViewController = storyboard.instantiateViewController(identifier: "MapViewController") as? MapViewController
        let mapInteractor = MapBusinessLogicSpy()
        
        mapViewController?.interactor = mapInteractor
        
        sut = mapViewController
        interactor = mapInteractor
        window = mainWindow
        
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        window = nil
        
        super.tearDown()
    }
    
    func testViewDidLoad() {
        
        sut.viewWillAppear(true)
        
        XCTAssertTrue(interactor.isCalledFetchCoordinates, "Not started interactor.fetchCoordinates(:)")
    }
    
}
