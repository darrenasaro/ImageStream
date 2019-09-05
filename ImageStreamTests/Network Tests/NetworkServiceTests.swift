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
    
    func test_NetworkService_fetchWhenDownloaderSucceedsAndMapperSucceeds_succeeds() {
        let downloader = NetworkDownloaderStub(data: Data())
        let mapper = MapperStub(decodable: DecodableDummy())
        let networkService = NetworkService<MapperStub>(downloader: downloader, mapper: mapper)
        let promise = expectation(description: "NetworkService fetch succeeds")
        
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): promise.fulfill()
            case .failure(_): XCTFail("NetworkService fetch failed when it should have succeeded")
            }
        }
        
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_NetworkService_fetchWhenDownloaderFailsAndMapperSucceeds_fails() {
        let downloader = NetworkDownloaderStub(error: TestError.failure)
        let mapper = MapperStub(decodable: DecodableDummy())
        let networkService = NetworkService<MapperStub>(downloader: downloader, mapper: mapper)
        let promise = expectation(description: "NetworkService fetch fails")
        
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): XCTFail("NetworkService fetch succeeded when it should have failed")
            case .failure(_): promise.fulfill()
            }
        }
        
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_NetworkService_fetchWhenDownloaderFailsAndMapperFails_fails() {
        let downloader = NetworkDownloaderStub(error: TestError.failure)
        let mapper = MapperStub(error: TestError.failure)
        let networkService = NetworkService<MapperStub>(downloader: downloader, mapper: mapper)
        let promise = expectation(description: "NetworkService fetch fails")
        
        networkService.fetch(from: "") { (result) in
            switch result {
            case .success(_): XCTFail("NetworkService fetch succeeded when it should have failed")
            case .failure(_): promise.fulfill()
            }
        }
        
        self.wait(for: [promise], timeout: 1.0)
    }
    
    func test_NetworkService_fetchWhenDownloaderSucceedsAndMapperFails_fails() {
        let downloader = NetworkDownloaderStub(data: Data())
        let mapper = MapperStub(error: TestError.failure)
        let networkService = NetworkService<MapperStub>(downloader: downloader, mapper: mapper)
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
    enum TestError: Error {
        case failure
    }
    
    struct DecodableDummy: Decodable { }
    
    class NetworkDownloaderStub: NetworkDownloader {
        var result: Result<Data, Error>
        
        init(error: Error) {
            result = .failure(error)
        }
        
        init(data: Data) {
            result = .success(data)
        }
        
        func fetch(from url: String, completion: @escaping (Result<Data, Error>) -> ()) {
            return completion(result)
        }
    }
    
    class MapperStub: Mapper {
        var error: Error?
        var decodable: Decodable?
        
        init(error: Error) {
            self.error = error
        }
        
        init(decodable: Decodable) {
            self.decodable = decodable
        }
        
        func map(data: Data) throws -> Decodable {
            guard let decodable = decodable else { throw error! }
            return decodable
        }
    }
}
