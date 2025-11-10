//
//  Store.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import Combine
import Foundation


final class Store: ObservableObject {
    @Published private(set) var state: AppState
    private let reducer: (inout AppState, AppAction) -> Void
    private let apiClient: APIClient
    
    
    init(initial: AppState = AppState(), reducer: @escaping (inout AppState, AppAction) -> Void = appReducer, apiClient: APIClient = APIClient()) {
        self.state = initial
        self.reducer = reducer
        self.apiClient = apiClient
    }
    
    
    func dispatch(_ action: AppAction) {
        // handle side-effects for fetch
        switch action {
        case .fetchAsteroids(let startDate, let endDate):
            reducer(&state, .setLoading(true))
            apiClient.fetchFeed(startDate: startDate, endDate: endDate) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let neos):
                        self?.reducer(&self!.state, .setAsteroids(neos))
                    case .failure(let error):
                        self?.reducer(&self!.state, .setError(error.localizedDescription))
                    }
                }
            }
        default:
            reducer(&state, action)
        }
    }
}
