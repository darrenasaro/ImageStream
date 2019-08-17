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
        FlickrPhotoInfoCoordinator().get { (result) in
            switch result {
            case .success(let photoInfo): print(photoInfo)
            case .failure(let error)    : print(error)
            }
        }
    }
}

