//
//  MockURLSession.swift
//  BOTPAssignment
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import Foundation

final class MockURLSession: URLSession {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
}

final class MockURLSessionDataTask: URLSessionDataTask {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        completion()
    }
}

