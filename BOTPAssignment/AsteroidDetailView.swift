//
//  AsteroidDetailView.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import SwiftUI

struct AsteroidDetailView: View {
    let neo: Neo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // MARK: - Header
                Text(neo.name)
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 4)
                
                // MARK: - Basic Info
                Text("Absolute magnitude: \(neo.absoluteMagnitudeH)")
                Text("Estimated diameter: \(String(format: "%.3f", neo.estimatedDiameter.kilometers.estimatedDiameterMin)) - \(String(format: "%.3f", neo.estimatedDiameter.kilometers.estimatedDiameterMax)) km")
                Text("Potentially hazardous: \(neo.isPotentiallyHazardousAsteroid ? "Yes" : "No")")
                    .foregroundColor(neo.isPotentiallyHazardousAsteroid ? .red : .green)
                    .bold()
                
                // MARK: - Close Approach Data
                if let approach = neo.closeApproachData.first {
                    Divider()
                        .padding(.vertical, 8)
                    
                    Text("Close approach date: \(approach.closeApproachDate)")
                    Text("Velocity (km/h): \(approach.relativeVelocity.kilometersPerHour)")
                    Text("Miss distance (km): \(approach.missDistance.kilometers)")
                    Text("Orbiting body: \(approach.orbitingBody)")
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(neo.name)
    }
}

#Preview {
    // Example preview data
    let sampleNeo = Neo(
        neoReferenceID: "12345",
        name: "2025 AB",
        absoluteMagnitudeH: 22.5,
        estimatedDiameter: EstimatedDiameter(kilometers: DiameterRange(estimatedDiameterMin: 0.05, estimatedDiameterMax: 0.12)),
        isPotentiallyHazardousAsteroid: true,
        closeApproachData: [
            CloseApproach(
                closeApproachDate: "2025-11-15",
                relativeVelocity: Velocity(kilometersPerHour: "54321"),
                missDistance: MissDistance(kilometers: "1234567"),
                orbitingBody: "Earth"
            )
        ]
    )
    
    AsteroidDetailView(neo: sampleNeo)
}

