//
//  FlickrPhotoInfo.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

protocol PhotoInfo {
    var url: String { get }
}

struct FlickrPhotoInfo: PhotoInfo {
    let id: String
    let url: String
    //let username: String
    let description: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case photo
    }

    enum PhotoKeys: String, CodingKey {
        case id
        case description
        case dates
        case urls
    }

    enum DescriptionKeys: String, CodingKey {
        case content = "_content"
    }

    enum DatesKeys: String, CodingKey {
        case posted
    }

    enum URLsKeys: String, CodingKey {
        case url
    }
}

extension FlickrPhotoInfo: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let photosContainer = try values.nestedContainer(keyedBy: PhotoKeys.self, forKey: .photo)

        let descriptionContainer = try photosContainer.nestedContainer(keyedBy: DescriptionKeys.self, forKey: .description)
        let datesContainer = try photosContainer.nestedContainer(keyedBy: DatesKeys.self, forKey: .dates)
        let urlsContainer = try photosContainer.nestedContainer(keyedBy: URLsKeys.self, forKey: .urls)

        id = try photosContainer.decode(String.self, forKey: .id)
        description = try descriptionContainer.decode(String.self, forKey: .content)
        date = try datesContainer.decode(String.self, forKey: .posted)
        url = (try urlsContainer.decode([FlickrPhotoInfoURL].self, forKey: .url))[0].url
    }
}

struct FlickrPhotoInfoURL: Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "_content"
    }
}
