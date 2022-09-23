//
//  NetworkingManagerCreateSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 23/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

class NetworkingManagerCreateSuccessMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: Endpoint, ofType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws { }
}
