//
//  PostRequest.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 4/05/21.
//

import Foundation

struct PostRequest: Codable {
    let text: String
    let imageUrl: String?
    let videoUrl: String?
    let location: PostRequestLocation?
}
