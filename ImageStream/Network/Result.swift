//
//  Result.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/22/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Holds a either success data or an error
enum Result<T, U: Error> {
    case success(_ result: T)
    case failure(_ error: U)
}
