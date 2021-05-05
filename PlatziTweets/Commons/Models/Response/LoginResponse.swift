//
//  LoginResponse.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 4/05/21.
//

import Foundation

struct LoginResponde: Codable {
    let user: User
    let token: String
}
