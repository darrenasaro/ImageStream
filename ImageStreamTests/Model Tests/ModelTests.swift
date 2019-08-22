//
//  ImageStreamTests.swift
//  ImageStreamTests
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import XCTest
@testable import ImageStream

class ModelTests: XCTestCase {

    func test_FlickrPhotoSearchResult_decodableWithMapper() {
        let JSON = """
        {"photos":{"page":1,"pages":1926027,"perpage":1,"total":"1926027","photo":[{"id":"1259861303","owner":"7572839@N05","secret":"b085800c3a","server":"1276","farm":2,"title":"Surf","ispublic":1,"isfriend":0,"isfamily":0,"description":{"_content":""},"dateupload":"1188330442","ownername":"saute_egail","url_o":"https://live.staticflickr.com/1276/1259861303_edbc87122e_o.jpg","height_o":"1297","width_o":"1103"}]},"stat":"ok"}
        """.data(using: .utf8)!
        let mapper = JSONMapper<FlickrPhotoSearchResult>()
        guard let mappedModel = try? mapper.map(data: JSON) as? FlickrPhotoSearchResult else { return XCTFail() }
        XCTAssertEqual(mappedModel.totalCount, 1926027)
        XCTAssertEqual(mappedModel.photos.count, 1)
    }
    
    func test_FlickrPhoto_decodableWithMapper() {
        let JSON = """
        {"id":"1259861303","owner":"7572839@N05","secret":"b085800c3a","server":"1276","farm":2,"title":"Surf","ispublic":1,"isfriend":0,"isfamily":0,"description":{"_content":""},"dateupload":"1188330442","ownername":"saute_egail","url_o":"https://live.staticflickr.com/1276/1259861303_edbc87122e_o.jpg","height_o":"1297","width_o":"1103"}
        """.data(using: .utf8)!
        let mapper = JSONMapper<FlickrPhoto>()
        guard let mappedModel = try? mapper.map(data: JSON) as? FlickrPhoto else { return XCTFail() }
        XCTAssertEqual(mappedModel.id, "1259861303")
        XCTAssertEqual(mappedModel.username, "saute_egail")
        XCTAssertEqual(mappedModel.description, "")
    }
}
