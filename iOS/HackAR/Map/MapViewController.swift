//
//  MapViewController.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import UIKit
import NMAKit

protocol MapViewControllerOutput {
    
    var view: MapViewControllerInput? { get set }
    
    func viewDidLoad()
}

class MapViewController: UIViewController {
    
    private enum Constants {
        static let coordinates = (59.929599, 30.305571)
    }
    
    private var mapMarkerMoveBeganEventHandlerId = 0
    private var mapMarkerMoveEndedEventHandlerId = 0
    private var mapMarkerMovedEventHandlerId = 0
    
    private lazy var mapView: NMAMapView = {
        let mapView = NMAMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let defaultGeo = NMAGeoCoordinates(latitude: Constants.coordinates.0,
                                           longitude: Constants.coordinates.1)
        mapView.set(geoCenter: defaultGeo, animation: .none)
        
        return mapView
    }()
    
    var output: MapViewControllerOutput?
    
    override func viewDidLoad() {
        title = "Карта"
        view.addSubview(mapView)
        output?.viewDidLoad()
    }
}

extension MapViewController: MapViewControllerInput {
    
    func appendPolygons(_ polygons: [NMAMapPolygon]) {
        mapView.add(mapObjects: polygons)
    }
    
    func appendUser(_ circle: NMAMapCircle) {
        mapView.add(mapObject: circle)
    }
    
    func pushAR() {
        navigationController?.pushViewController(buildAR(), animated: true)
    }
    
    private func buildAR() -> UIViewController {
        let rootVc = ARViewController()
        let presenter = ARPresenter()
        presenter.view = rootVc
        rootVc.output = presenter
        return rootVc
    }
}
