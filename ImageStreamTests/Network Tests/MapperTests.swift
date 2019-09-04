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
    struct DecodableStub: Decodable {
        let key: String
    }
    
    func test_JSONMapper_Map_Succeeds() {
        let mapper = JSONMapper<DecodableStub>()
        let data = """
                {"key": "value"}
            """.data(using: .utf8)!
        
        guard let model = try? mapper.map(data: data) as? DecodableStub else { return XCTFail() }
        
        guard model.key == "value" else { return XCTFail() }
    }
    
    func test_JSONMapper_Map_Fails() {
        let mapper = JSONMapper<DecodableStub>()
        let data = """
                {"wrongKey": "value"}
            """.data(using: .utf8)!
        
        XCTAssertThrowsError(try mapper.map(data: data))
    }
}
