//
//  File.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/15/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation

/// Abstraction for a type that produces a URL.
protocol Endpoint {
    var url: String { get }
}

/// Abstraction for a type that produces a URL which is dependent upon page arguments.
protocol PaginatedEndpoint: Endpoint {
    /// The page being requested.
    var page: Int { get }
    /// The amount of items per page requested.
    var perPage: Int { get }
    /// Copy self while only modifying the page.
    func copy(with newPage: Int) -> PaginatedEndpoint
}



