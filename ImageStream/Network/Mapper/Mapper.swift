//
//  Mapper.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

/// Abstraction for a type that can map Data into a different format
protocol Mapper {
    associatedtype OutputType
    func map(data: Data) throws -> OutputType
}
