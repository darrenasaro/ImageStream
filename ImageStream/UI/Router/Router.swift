//
//  Router.swift
//  ImageStream
//
//  Created by Darren Asaro on 9/4/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoDetailRouter {
    func route(to photo: Photo)
}

protocol InitialRouter {
    func start() -> UIViewController
}

typealias Router = PhotoDetailRouter & InitialRouter
