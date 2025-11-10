//
//  Reducer.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import Foundation


func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .fetchAsteroids:
        state.isLoading = true
        state.errorMessage = nil
    case .setAsteroids(let neos):
        state.asteroids = neos
        state.isLoading = false
        state.errorMessage = nil
    case .setLoading(let loading):
        state.isLoading = loading
    case .setError(let msg):
        state.errorMessage = msg
        state.isLoading = false
    }
}
