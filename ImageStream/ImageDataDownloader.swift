//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

//map to models from JSON
class ImageDataDownloader {
    
    private let downloader: NetworkDownloader
    
    init(downloader: NetworkDownloader = AFDownloader()) {
        self.downloader = downloader
    }
    
    //TODO: add callback with model
    func getImages(for url: String) {
        downloader.get(from: url) { (result) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
