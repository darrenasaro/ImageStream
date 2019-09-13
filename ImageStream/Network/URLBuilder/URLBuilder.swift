//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Abstraction for a type that produces a URL.
protocol URLBuilder {
    var url: String { get }
}

/// Abstraction for a type that produces a URL which is dependent upon page arguments.
protocol PaginatedURLBuilder: URLBuilder {
    /// The page being requested.
    var page: Int { get set }
    /// The amount of items per page requested.
    var perPage: Int { get set }
}


