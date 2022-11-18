//
//  Pagination.swift
//  GiphyTestWork
//
//  Created by Михаил on 18.11.2022.
//

import Foundation

struct Pagination: Decodable {
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
    }
}
