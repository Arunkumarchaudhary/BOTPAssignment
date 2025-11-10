//
//  BOTPAssignmentApp.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import SwiftUI


@main
struct AsteroidsApp: App {
    @StateObject private var store = Store()
    
    
    var body: some Scene {
        WindowGroup {
            AsteroidListView()
                .environmentObject(store)
        }
    }
}
