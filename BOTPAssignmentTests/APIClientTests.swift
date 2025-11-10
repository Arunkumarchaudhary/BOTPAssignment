//
//  APIClientTests.swift
//  BOTPAssignmentTests
//
//  Created by Arun Kumar Chaudhary on 10/11/25.
//

import Testing
import XCTest

@testable import BOTPAssignment

final class APIClientTests: XCTestCase {
    
    var apiClient: APIClient!
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        apiClient = APIClient(apiKey: "TEST_KEY", session: mockSession)
    }
    
    override func tearDown() {
        apiClient = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testFetchFeedSuccess() {
        // Arrange
        let json = """
        {
          "near_earth_objects": {
            "2025-11-10": [
              {
                "id": "123",
                "name": "Test Asteroid",
                "is_potentially_hazardous_asteroid": false
              }
            ]
          }
        }
        """
        
        mockSession.data = json.data(using: .utf8)
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.nasa.gov")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let expectation = XCTestExpectation(description: "FetchFeed completes")
        
        // Act
        apiClient.fetchFeed(startDate: "2025-11-09", endDate: "2025-11-10") { result in
            // Assert
            switch result {
            case .success(let neos):
                XCTAssertEqual(neos.count, 1)
                XCTAssertEqual(neos.first?.name, "Test Asteroid")
            case .failure(let error):
                XCTFail("Expected success but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    
    func testFetchFeedFailure_invalidJSON() {
        // Arrange
        mockSession.data = "Invalid JSON".data(using: .utf8)
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.nasa.gov")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let expectation = XCTestExpectation(description: "FetchFeed completes with error")
        
        // Act
        apiClient.fetchFeed(startDate: "2025-11-09", endDate: "2025-11-10") { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected decoding failure")
            case .failure(let error):
                XCTAssertNotNil(error, "Expected decoding error")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    
    func testFetchNeoDetailsSuccess() {
        // Arrange
        let json = """
        {
          "id": "123",
          "name": "Test Neo",
          "is_potentially_hazardous_asteroid": false
        }
        """
        mockSession.data = json.data(using: .utf8)
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.nasa.gov")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let expectation = XCTestExpectation(description: "FetchNeoDetails completes")
        
        // Act
        apiClient.fetchNeoDetails(neoID: "123") { result in
            // Assert
            switch result {
            case .success(let neo):
                XCTAssertEqual(neo.name, "Test Neo")
                XCTAssertFalse(neo.isPotentiallyHazardousAsteroid)
            case .failure(let error):
                XCTFail("Expected success but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
