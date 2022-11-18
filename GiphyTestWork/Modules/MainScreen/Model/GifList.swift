//
//  GifList.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation

struct GifList: Decodable {
    let data: [Gif]
    let pagination: Pagination
}
