//
//  Feature.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation

struct FeatureCollection: Codable {
    
    let type: String
    let etag: String
    
    let features: [Feature]
}

struct Feature: Codable {
    
    let id: String
    let type: String
    
    let geometry: Geometry
}

struct Geometry: Codable {
    
    let type: String
    
    let coordinates: [[[[Double]]]]
}
