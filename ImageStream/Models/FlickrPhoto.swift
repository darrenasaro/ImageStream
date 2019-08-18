//
//  FlickrPhoto.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

protocol Photo: Decodable {
    var url: String { get }
}

struct FlickrPhoto: Photo {
    let id: String
    let description: String
    let username: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case secret
        case server
        case farm
        case description
        case username = "ownername"
        case url
    }
    
    enum DescriptionKeys: String, CodingKey {
        case content = "_content"
    }
}

extension FlickrPhoto: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let descriptionContainer = try values.nestedContainer(keyedBy: DescriptionKeys.self, forKey: .description)
        
        id = try values.decode(String.self, forKey: .id)
        username = try values.decode(String.self, forKey: .username)
        description = try descriptionContainer.decode(String.self, forKey: .content)
        
        let secret = try values.decode(String.self, forKey: .secret)
        let server = try values.decode(String.self, forKey: .server)
        let farm = try values.decode(Int.self, forKey: .farm)
        url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
