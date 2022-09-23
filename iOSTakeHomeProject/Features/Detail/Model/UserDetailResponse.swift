//
//  UserDetailResponse.swift
//  iOSTakeHomeProject
//
//  Created by Tomasz Ogrodowski on 21/09/2022.
//

import Foundation

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable, Equatable {
    let data: User
    let support: Support
}


