//
//  MockURLSessionProtocol.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tomasz Ogrodowski on 22/09/2022.
//

#if DEBUG

import Foundation


class MockURLSessionProtocol: URLProtocol {
    
    /// We return (HTTPURLResponse, Data?) within the closure so that we can actually set within the network request that we simulate the status code and
    /// any data that we get back from this fake URLSession
    /// We are to use this handler within our actual startLoading()
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
    
    // Functions to control how request is handled when we execute it within fake mock.
    
    /// allows to control whether it can handle a given request.
    override class func canInit(with request: URLRequest) -> Bool {
        /// We always want to return true because we always want it to return some kind of value when we try to execute this fake request
        return true
    }
    
    /// returns a fake version of the request
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /// Function where we control the mock response that we get back from this fake URLSession that we're going to build.
    override func startLoading() {
        guard let handler = MockURLSessionProtocol.loadingHandler else {
            fatalError("Loading handler is not set.")
        }
        
        let (response, data) = handler()
        // Simulating receiving a response
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data {
            // Simulating loading data
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}

#endif
