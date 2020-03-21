//
//  SceneCreator.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation
import CoreLocation
import ARKit

enum SceneCreator {
    
    private static let defaultSphere: SCNSphere = {
        let sphere = SCNSphere(radius: 4)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        sphere.isGeodesic = true
        sphere.materials = [material]
        return sphere
    }()
    
    static func createNode() -> SCNNode {
        return SCNNode(geometry: defaultSphere)
    }
}
