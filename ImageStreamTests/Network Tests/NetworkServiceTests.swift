//
//  NetworkDownloaderTests.swift
//  ImageStreamTests
//
//  Created by Darren Asaro on 8/22/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import XCTest
@testable import ImageStream

class GeneralServiceTests: XCTestCase {

    func test_fetch_whenDownloaderFails_succeeds() {
        let dummy = MappedDummy()
        let downloader = NetworkDownloaderStub(error: ErrorFake.failure)
        let mapper = MapperStub(object: dummy)
        let sut = GeneralService<MapperStub>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "Data matches")
        sut.fetch(from: "") { result in
            switch result {
            case .success(_): XCTFail()
            case .failure(let error):
                guard case ErrorFake.failure = error else { return XCTFail() }
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 1.0)
    }
    
    func test_fetch_whenDownloaderSucceedsMapperSucceeds_fails() {
        let data = Data()
        let dummy = MappedDummy()
        let downloader = NetworkDownloaderStub(data: data)
        let mapper = MapperStub(object: dummy)
        let sut = GeneralService<MapperStub>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "Data matches")
        sut.fetch(from: "") { result in
            switch result {
            case .success(let model):
                guard model === dummy else { return XCTFail() }
                promise.fulfill()
            case .failure(_): XCTFail()
            }
        }
        
        wait(for: [promise], timeout: 1.0)
    }
    
    func test_fetch_whenDownloaderSucceedsMapperFails_fails() {
        let data = Data()
        let downloader = NetworkDownloaderStub(data: data)
        let mapper = MapperStub(error: ErrorFake.failure)
        let sut = GeneralService<MapperStub>(downloader: downloader, mapper: mapper)
        
        let promise = expectation(description: "Data matches")
        sut.fetch(from: "") { result in
            switch result {
            case .success(_): XCTFail()
            case .failure(let error):
                guard case ErrorFake.failure = error else { return XCTFail() }
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 1.0)
    }
}

extension GeneralServiceTests {
    enum ErrorFake: Error {
        case failure
    }

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
    
    class MappedDummy { }
    
    class MapperStub: Mapper {
        var error: Error?
        var object: MappedDummy?
        
        init(error: Error) {
            self.error = error
        }
        
        init(object: MappedDummy) {
            self.object = object
        }
        
        func map(data: Data) throws -> MappedDummy {
            guard let object = object else { throw error! }
            return object
        }
    }
}
