//
//  Photo.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

struct FlickrPhotoSearchResult {
    let totalCount: Int
    let flickrPhotos: [FlickrPhoto]
    
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
        let photos = try values.nestedContainer(keyedBy: PhotosCodingKeys.self, forKey: .photos)
        
        totalCount = Int(try photos.decode(String.self, forKey: .totalCount))!
        flickrPhotos = try photos.decode([FlickrPhoto].self, forKey: .photo)
    }
}
