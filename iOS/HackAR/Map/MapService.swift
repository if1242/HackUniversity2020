//
//  MapService.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation
import NMAKit

class MapService {
    
    private enum Constants {
        static let iterate = "https://xyz.api.here.com/hub/spaces/00YTlwR2/iterate?access_token=ALPViduFS_CPPflaGcu1IwA"
    }
    
    func loadPolygons(result: @escaping ((Result<[NMAMapPolygon], Error>) -> Void)) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: Constants.iterate) else {
            return
        }
        let dataTask = session.dataTask(with: url) {
            [weak self] data, response, e in
            
            if let error = e {
                result(.failure(error))
            }
            
            guard let data = data else {
                return
            }
            
            if case .success(let features) = self?.mapResult(data) {
                result(.success(features.mapPolygons))
            }
        }
        dataTask.resume()
    }
    
    private func mapResult(_ data: Data) -> Result<FeatureCollection, Error> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return Result { try decoder.decode(FeatureCollection.self, from: data) }.mapError { e -> Error in
            print(e)
            return e
        }
        
    }
}

private extension FeatureCollection {
    
    var mapPolygons: [NMAMapPolygon] {
        
        return features.map {
            feature -> NMAMapPolygon in
            
            let geoCoordinates = feature.geometry.coordinates
                .flatMap { $0 }
                .flatMap { $0 }
                .compactMap {
                    coordinates -> NMAGeoCoordinates? in
                    
                    guard coordinates.count == 2 else {
                        return nil
                    }
                    return NMAGeoCoordinates(latitude: coordinates[1],
                                             longitude: coordinates[0])
            }
            let geoPolygon = NMAGeoPolygon(coordinates: geoCoordinates)
            let mapPolygon = NMAMapPolygon(polygon: geoPolygon)
            mapPolygon.lineColor = UIColor.green
            mapPolygon.lineWidth = 2
            mapPolygon.fillColor = UIColor.yellow
            return mapPolygon
        }
    }
}
