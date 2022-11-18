//
//  GifImage.swift
//  GiphyTestWork
//
//  Created by Михаил on 18.11.2022.
//

import Foundation

struct GifImages: Decodable {
    let original: GifImageParameters
    let fixedWidthDownsampled: GifImageParameters
    let previewGif: GifImageParameters
    
    enum CodingKeys: String, CodingKey {
        case previewGif = "preview_gif"
        case original
        case fixedWidthDownsampled = "fixed_width_downsampled"
    }
}


