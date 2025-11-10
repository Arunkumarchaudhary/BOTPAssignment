//
//  AsteroidRow.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import SwiftUI


struct AsteroidRow: View {
    let neo: Neo
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(neo.name).font(.headline)
                Text("H: \(neo.absoluteMagnitudeH)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if neo.isPotentiallyHazardousAsteroid {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 8)
    }
}
