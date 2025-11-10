//
//  ContentView.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//
import SwiftUI
import Foundation

struct AsteroidListView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack {
            Group {
                if store.state.isLoading {
                    ProgressView("Loading...")
                } else if let err = store.state.errorMessage {
                    Text("Error: \(err)")
                        .foregroundColor(.red)
                } else {
                    List(store.state.asteroids) { neo in
                        NavigationLink(destination: AsteroidDetailView(neo: neo)) {
                            AsteroidRow(neo: neo)
                        }
                    }
                }
            }
            .navigationTitle("Near-Earth Asteroids")
            .task {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let start = Date()
                let end = Calendar.current.date(byAdding: .day, value: 7, to: start)!
                store.dispatch(.fetchAsteroids(
                    startDate: formatter.string(from: start),
                    endDate: formatter.string(from: end)
                ))
            }
        }
    }
}

#Preview {
    AsteroidListView().environmentObject(Store())
}
