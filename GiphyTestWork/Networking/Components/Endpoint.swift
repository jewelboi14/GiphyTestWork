//
//  Endpoint.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [HTTPHeader]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.giphy.com"
    }
    
    var apiKey: String {
        return "RuPXcT9RSSSMUs8ZmpTGcivWQAwH3WwD"
    }
    
    func request(offset: Int) -> URLRequest {
        
        
        var components = URLComponents()
        var baseQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(20)")
        ]
        
        baseQueryItems.append(contentsOf: queryItems)
        
        components.scheme = scheme
        components.host = host
        components.path = path
        
        components.queryItems = baseQueryItems
        
        guard let url = components.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        header?.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
        
    }
}
