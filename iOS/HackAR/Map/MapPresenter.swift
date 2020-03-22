//
//  MapPresenter.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation
import NMAKit

protocol MapViewControllerInput: AnyObject {
    
    var output: MapViewControllerOutput? { get set }
    
    func appendPolygons(_ polygons: [NMAMapPolygon])
    func appendUser(_ circle: NMAMapCircle)
    func pushAR()
}

class MapPresenter {
    
    private enum Constants {
        static let imageName = "Vector-16.png"
    }
    
    weak var view: MapViewControllerInput?
    
    private let service = MapService()
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
}

extension MapPresenter: MapViewControllerOutput {
    
    func viewDidLoad() {
        service.loadPolygons {
            [weak self] result in
            
            if case .success(let polygons) = result {
                self?.view?.appendPolygons(polygons)
            }
            let userCoordinates = NMAGeoCoordinates(latitude: 59.929631,
                                                    longitude: 30.305279)
            let user = NMAMapCircle(userCoordinates, radius: 1)
            user.fillColor = UIColor.red
            self?.view?.appendUser(user)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                [weak self] in
                
                self?.view?.pushAR()
            }
        }
    }
    
    private func buildAR() -> UIViewController {
        let rootVc = ARViewController()
        let presenter = ARPresenter()
        presenter.view = rootVc
        rootVc.output = presenter
        return rootVc
    }
}
