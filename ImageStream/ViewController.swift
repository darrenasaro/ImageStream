//
//  ViewController.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let apiRequest = FlickrPhotoSearchRequestBuilder(searchString: "surf")
        FlickrPhotoSearchService().get(from: apiRequest.url)
    }
}

