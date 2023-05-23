//
//  DataBaseManager.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 13.05.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    // firestore instance
    let db = Firestore.firestore()
    // path for users in collection
    let usersPath: String = "users"
    let tweetsPath: String = "Tweets"
    
    
    // add user to collection
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        // access collection by pass // creating new doc with id // set data
        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser).map { _ in
            // if successfull true
            return true
        }.eraseToAnyPublisher()
    }
    
    // retreive user
    func collectionUsers(retreive id: String) -> AnyPublisher<TwitterUser, Error> {
                                                                      // decode data
        db.collection(usersPath).document(id).getDocument().tryMap { try  $0.data(as: TwitterUser.self)}.eraseToAnyPublisher()
    }
    
    // update users data
    func colletionUsers(updateFields: [String : Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).updateData(updateFields).map { _ in true }.eraseToAnyPublisher()
    }
    
    // send tweet
    func collectionTweets(dispatch tweet: Tweet) -> AnyPublisher<Bool, Error> {
        db.collection(tweetsPath).document(tweet.id).setData(from: tweet).map { _ in
            // if successfull true
            return true
        }.eraseToAnyPublisher()
    }
    
    
    // get user tweets
    func collectionTweets(retreiveTweets forUserID: String) -> AnyPublisher<[Tweet], Error> {
        db.collection(tweetsPath).whereField("authorID", isEqualTo: forUserID).getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Tweet.self)
                })
            }.eraseToAnyPublisher()
    }
    
    // get all tweets
    func collectionTweets() -> AnyPublisher<[Tweet], Error> {
        db.collection(tweetsPath).getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Tweet.self)
                })
            }.eraseToAnyPublisher()
    }
    
}
