//
//  APIClient.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import Foundation


final class APIClient {
    private let apiKey: String
    private let urlSession: URLSession
    
    
    init(apiKey: String = "DEMO_KEY", session: URLSession = .shared) {
        self.apiKey = apiKey
        self.urlSession = session
    }
    
    
    func fetchFeed(startDate: String, endDate: String, completion: @escaping (Result<[Neo], Error>) -> Void) {
        var components = URLComponents(string: "https://api.nasa.gov/neo/rest/v1/feed")!
        components.queryItems = [
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        
        guard let url = components.url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failure:",error)
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let feed = try decoder.decode(NeoFeedResponse.self, from: data)
                print("resopunseValue:",feed)
                // flatten dictionary into an array sorted by date (optional)
                let neos = feed.nearEarthObjects.values.flatMap { $0 }
                
                completion(.success(neos))
            } catch {
                print("FailureCatch",error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Git testing
    func fetchNeoDetails(neoID: String, completion: @escaping (Result<Neo, Error>) -> Void) {
        var components = URLComponents(string: "https://api.nasa.gov/neo/rest/v1/neo/\(neoID)")!
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        guard let url = components.url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let task = urlSession.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(URLError(.badServerResponse))); return }
            do {
                let decoder = JSONDecoder()
                let neo = try decoder.decode(Neo.self, from: data)
                completion(.success(neo))
            } catch { completion(.failure(error)) }
        }
        task.resume()
    }
}
