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
    
}
