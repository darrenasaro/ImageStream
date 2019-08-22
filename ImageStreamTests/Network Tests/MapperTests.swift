//
//  MapperTests.swift
//  ImageStreamTests
//
//  Created by Darren Asaro on 8/22/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import XCTest
@testable import ImageStream

class MapperTests: XCTestCase {
    struct TestDecodable: Decodable {
        let key: String
    }
    
    func test_JSONMapper_succeeds() {
        let mapper = JSONMapper<TestDecodable>()
        let data = """
                {"key": "value"}
            """.data(using: .utf8)!
        guard let model = try? mapper.map(data: data) as? TestDecodable else { return XCTFail() }
        guard model.key == "value" else { return XCTFail() }
    }
    
    func test_JSONMapper_fails() {
        let mapper = JSONMapper<TestDecodable>()
        let data = """
                {"wrongKey": "value"}
            """.data(using: .utf8)!
        XCTAssertThrowsError(try mapper.map(data: data))
    }
}
