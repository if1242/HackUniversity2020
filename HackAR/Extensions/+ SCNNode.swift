//
//  + SCNNode.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation
import ARKit
import CoreLocation.CLLocation

extension SCNNode {
    
    func updatePosition(_ first: CLLocation, _ second: CLLocation) {
        position = first.translatedVectorTo(second)
        let distance = Float(first.distance(from: second))
        scale = first.scaled(distance: distance)
    }
}
