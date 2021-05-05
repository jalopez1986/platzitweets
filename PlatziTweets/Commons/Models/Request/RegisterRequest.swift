//
//  RegisterRequest.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 4/05/21.
//

import Foundation

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let names: String
}
