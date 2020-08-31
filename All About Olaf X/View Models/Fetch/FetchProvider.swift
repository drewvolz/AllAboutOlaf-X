//
//  FetchProvider.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/22/20.
//

import Foundation
import Combine

public struct Response<T> {
    let value: T
    let response: URLResponse
}

public enum FetchResponse {
    public typealias News = AnyPublisher<Response<[NewsResponse]>, Error>
    public typealias Orgs = AnyPublisher<Response<[Org]>, Error>
    public typealias Directory = AnyPublisher<Response<SearchUserResponse>, Error>
    public typealias Menu = AnyPublisher<Response<MenuResponse>, Error>
    public typealias Cafes = AnyPublisher<Response<[CafeListResponse]>, Error>
}

public protocol FetchProvider {
    func getNews(url: String) -> FetchResponse.News
    func getOrgs() -> FetchResponse.Orgs
    func searchDirectory(url: String) -> FetchResponse.Directory
    func getCafeMenu(url: String) -> FetchResponse.Menu
    func getCafeList() -> FetchResponse.Cafes
}
