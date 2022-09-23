//
//  UsersResponse.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 21/09/2022.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable, Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}

