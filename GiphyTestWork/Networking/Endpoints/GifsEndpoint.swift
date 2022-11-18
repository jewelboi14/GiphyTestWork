//
//  GifsEndpoint.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation

enum GifsEndpoint {
    case trending
    case categories
    case search(String)
}

extension GifsEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .trending:
            return "/v1/gifs/trending"
        case .categories:
            return "/v1/gifs/categories"
        case .search:
            return "/v1/gifs/search"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let queryParameter):
            return [
                URLQueryItem(name: "q", value: queryParameter)
            ]
        default: return []
        }
    }
    
    var header: [HTTPHeader]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
}
