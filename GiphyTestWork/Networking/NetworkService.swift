//
//  NetworkService.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation

final class NetworkService {
    
    func sendRequest<T: Decodable>(
        request: URLRequest,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        
        do {
            let (data, response) = try await URLSession.shared.data(
                for: request,
                delegate: nil
            )
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(
                    responseModel,
                    from: data
                ) else { return .failure(.decode) }
                
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
            
        } catch {
            return .failure(.unknown)
        }
    }
    
}
