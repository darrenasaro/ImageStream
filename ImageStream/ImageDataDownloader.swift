//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//downloads and converts data to JSON
class NetworkService<T: Decodable> {
    private let downloader: NetworkDownloader
    
    init(downloader: NetworkDownloader = AFDownloader()) {
        self.downloader = downloader
    }
    
    func get(from url: String) {
        downloader.get(from: url) { (result) in
            switch result {
            case .success(let result):
                do {
                    let searchResult = try JSONDecoder().decode(T.self, from: result)
                    print(searchResult)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

class FlickrPhotoSearchService: NetworkService<FlickrPhotoSearchResult> { }
