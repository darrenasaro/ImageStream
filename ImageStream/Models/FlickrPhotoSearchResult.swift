//
//  Photo.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Abstraction for a type that describes a result from a search for photos.
protocol PhotoSearchResult: Decodable {
    associatedtype T:Photo
    /// The total number of photos that the search is capable of returning.
    var totalCount: Int { get }
    /// The photos that the search returned.
    var photos: [T] { get }
}

/// PhotoSearchResult that can be decoded from JSON from the Flickr API.
struct FlickrPhotoSearchResult: PhotoSearchResult {
    let totalCount: Int
    let photos: [FlickrPhoto]
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
    
    enum PhotosCodingKeys: String, CodingKey {
        case photo
        case totalCount = "total"
    }
}

extension FlickrPhotoSearchResult: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let photosContainer = try values.nestedContainer(keyedBy: PhotosCodingKeys.self, forKey: .photos)
        
        totalCount = Int(try photosContainer.decode(String.self, forKey: .totalCount))!
        photos = try photosContainer.decode([FlickrPhoto].self, forKey: .photo)
    }
}
