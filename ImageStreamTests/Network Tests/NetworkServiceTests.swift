//
//  NetworkDownloaderTests.swift
//  ImageStreamTests
//
//  Created by Darren Asaro on 8/22/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import XCTest
@testable import ImageStream

class NetworkServiceTests: XCTestCase {

    func test_downloaderSucceeds() {
        let downloader = MockNetworkDownloader(succeeds: true)
        let promise = expectation(description: "Downloader fetch success")
        downloader.fetch(from: "") { (result) in
            switch result {
            case .success(_): promise.fulfill()
            case .failure(_): XCTFail()
            }
        }
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_downloaderFails() {
        let downloader = MockNetworkDownloader(succeeds: false)
        let promise = expectation(description: "Downloader fetch fails")
        downloader.fetch(from: "") { (result) in
            switch result {
            case .success(_): XCTFail()
            case .failure(_): promise.fulfill()
            }
        }
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_mapperSucceeds() {
        let mapper = MockMapper(succeeds: true)
        XCTAssertNoThrow(try mapper.map(data: Data()))
    }
    
    func test_mapperFails() {
        let mapper = MockMapper(succeeds: false)
        XCTAssertThrowsError(try mapper.map(data: Data()))
    }
    
    func test_networkServiceSucceeds_when_downloaderSucceeds_mapperSucceeds() {
        let downloader = MockNetworkDownloader(succeeds: true)
        let mapper = MockMapper(succeeds: true)
        let networkService = NetworkService<MockDecodable>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "NetworkService fetch succeeds")
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): promise.fulfill()
            case .failure(_): XCTFail("NetworkService fetch failed when it should have succeeded")
            }
        }
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_networkServiceFails_when_downloaderFails_mapperSucceeds() {
        let downloader = MockNetworkDownloader(succeeds: false)
        let mapper = MockMapper(succeeds: true)
        let networkService = NetworkService<MockDecodable>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "NetworkService fetch fails")
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): XCTFail("NetworkService fetch succeeded when it should have failed")
            case .failure(_): promise.fulfill()
            }
        }
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_networkServiceFails_when_downloaderFails_mapperFails() {
        let downloader = MockNetworkDownloader(succeeds: false)
        let mapper = MockMapper(succeeds: false)
        let networkService = NetworkService<MockDecodable>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "NetworkService fetch fails")
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): XCTFail("NetworkService fetch succeeded when it should have failed")
            case .failure(_): promise.fulfill()
            }
        }
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_networkServiceFails_when_downloaderSucceds_mapperFails() {
        let downloader = MockNetworkDownloader(succeeds: true)
        let mapper = MockMapper(succeeds: false)
        let networkService = NetworkService<MockDecodable>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "NetworkService fetch fails")
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): XCTFail("NetworkService fetch succeeded when it should have failed")
            case .failure(_): promise.fulfill()
            }
        }
        self.wait(for: [promise], timeout: 1.0)
    }
}

extension NetworkServiceTests {
    enum MockError: Error {
        case failure
    }
    
    struct MockDecodable: Decodable { }
    
    class MockNetworkDownloader: NetworkDownloader {
        
        let succeeds: Bool
        
        init(succeeds: Bool) {
            self.succeeds = succeeds
        }
        
        func fetch(from url: String, completion: @escaping (Result<Data, Error>) -> ()) {
            return succeeds ? completion(.success(Data())) : completion(.failure(MockError.failure))
        }
    }
    
    class MockMapper: Mapper {
        var succeeds: Bool
        
        init(succeeds: Bool) {
            self.succeeds = succeeds
        }
        
        func map(data: Data) throws -> Any {
            if succeeds {
                return MockDecodable()
            } else {
                throw MockError.failure
            }
        }
    }
}
