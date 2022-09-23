//
//  NetworkingManagerUserDetailsResponseFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: Endpoint, ofType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws { }
}

