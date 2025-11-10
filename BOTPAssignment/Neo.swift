//
//  Neo.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import Foundation


struct NeoFeedResponse: Codable {
    let nearEarthObjects: [String: [Neo]]
    
    
    private enum CodingKeys: String, CodingKey {
        case nearEarthObjects = "near_earth_objects"
    }
}


struct Neo: Codable, Identifiable {
    var id: String { neoReferenceID }
    
    
    let neoReferenceID: String
    let name: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproach]
    
    
    private enum CodingKeys: String, CodingKey {
        case neoReferenceID = "neo_reference_id"
        case name
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
    }
}


struct EstimatedDiameter: Codable {
    let kilometers: DiameterRange
}


struct DiameterRange: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    
    private enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}


struct CloseApproach: Codable {
    let closeApproachDate: String
    let relativeVelocity: Velocity
    let missDistance: MissDistance
    let orbitingBody: String
    
    
    private enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}


struct Velocity: Codable {
    let kilometersPerHour: String
    
    
    private enum CodingKeys: String, CodingKey {
        case kilometersPerHour = "kilometers_per_hour"
    }
}


struct MissDistance: Codable {
    let kilometers: String
}
