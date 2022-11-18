//
//  Provider.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation

protocol Provider {
    var networkService: NetworkService { get set }
}

final class MainViewProvider: Provider {
    
    var networkService: NetworkService = NetworkService()
    
    func fetchCategories(offset: Int) async -> Result<CategoryList, RequestError> {
        await networkService.sendRequest(
            request: GifsEndpoint.categories.request(offset: offset),
            responseModel: CategoryList.self
        )
    }
    
    func fetchTrendingGifs(offset: Int) async -> Result<GifList, RequestError> {
        await networkService.sendRequest(
            request: GifsEndpoint.trending.request(offset: offset),
            responseModel: GifList.self
        )
    }
    
    func searchByCategory(
        offset: Int,
        categoryName: String
    ) async -> Result<GifList, RequestError> {
        await networkService.sendRequest(
            request: GifsEndpoint.search(categoryName).request(offset: offset),
            responseModel: GifList.self
        )
    }
}
