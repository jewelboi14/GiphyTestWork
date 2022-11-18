//
//  CategoryList.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation

struct CategoryList: Decodable {
    let data: [Category]
    let pagination: Pagination
}
