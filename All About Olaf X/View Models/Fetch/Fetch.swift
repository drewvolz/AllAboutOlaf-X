//
//  Fetch.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/22/20.
//  https://bitbucket.org/mariwi/implement-swift-generic-api-using-codable-and-combine/
//  https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/
//

import Combine
import SwiftUI

public extension Fetch {

    func getNews(url: String) -> FetchResponse.News {
        return call(url, method: .GET)
    }

    func getOrgs() -> FetchResponse.Orgs {
        return call(Urls.api.orgs, method: .GET)
    }

    func searchDirectory(url: String) -> FetchResponse.Directory {
        return call(url, method: .GET)
    }

    func getCafeMenu(url: String) -> FetchResponse.Menu {
        return call(url, method: .GET)
    }

    func getCafeList() -> FetchResponse.Cafes {
        return call(Urls.api.cafesList, method: .GET)
    }
}

public class Fetch: FetchProvider, ObservableObject {

    enum Method: String {
        case GET
        case POST
    }

    public init() {}

    private func call<T: Codable>(_ url: String, method: Method,
                                  body: Data = Data(),
                                  cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                                  token: String = "") -> AnyPublisher<Response<T>, Error> {

        let urlRequest = request(for: url, method: method, body: body, cachePolicy: cachePolicy, token: token)

        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func request(for url: String, method: Method, body: Data, cachePolicy: URLRequest.CachePolicy, token: String) -> URLRequest {

        guard let url = URL(string: url) else {
            preconditionFailure("Bad URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = cachePolicy
        
        if !body.isEmpty {
            request.httpBody = body
        }
        
        if !token.isEmpty {
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
