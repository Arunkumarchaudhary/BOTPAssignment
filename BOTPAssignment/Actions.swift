//
//  Actions.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//


import Foundation


enum AppAction {
    case fetchAsteroids(startDate: String, endDate: String)
    case setAsteroids([Neo])
    case setLoading(Bool)
    case setError(String?)
}
