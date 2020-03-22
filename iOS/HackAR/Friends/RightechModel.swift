//
//  RightechModel.swift
//  HackAR
//
//  Created by viktor.volkov on 22.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation

struct RightechModel: Codable {
    
    let model: String
    let id: String
    let name: String
    let description: String?
    let type: String
    let status: String
    let active: Bool
    let group: String
    let state: RightechState
}

struct RightechState: Codable {
    
    let id: String
    let HereID: Int?
    let MAC: String?
    let payload: String?
    
    var payloads: [String] {
        guard let payload = payload else {
            return []
        }
        return payload
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .components(separatedBy: ", ")
    }
}
