//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 19.05.2023.
//

import Foundation


struct Tweet: Codable, Identifiable {
    var id = UUID().uuidString
    let author: TwitterUser
    let authorID: String
    let tweetContent: String
    var likeCount: Int
    var likers: [String]
    let isReplied: Bool
    let parentReference: String?
}
