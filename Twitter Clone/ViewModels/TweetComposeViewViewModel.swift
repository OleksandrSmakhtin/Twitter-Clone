//
//  TweetComposeViewViewModel.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 19.05.2023.
//

import Foundation
import Combine
import FirebaseAuth

final class TweetComposeViewViewModel: ObservableObject {
    
    @Published var shouldDissmisComposer: Bool = false
    @Published var isValidToTweet: Bool = false
    @Published var error: String?
    var tweetContent = ""
    private var twitterUser: TwitterUser?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateToTweet() {
        isValidToTweet = !tweetContent.isEmpty
    }
    
    func getUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [unowned self] twitterUser in
            self.twitterUser = twitterUser
        }.store(in: &subscriptions)
    }
    
    func dispatchTweet() {
        guard let user = twitterUser else { return }
        let tweet = Tweet(author: user, authorID: user.id, tweetContent: tweetContent, likeCount: 0, likers: [], isReplied: false, parentReference: nil)
        
        DatabaseManager.shared.collectionTweets(dispatch: tweet).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            self?.shouldDissmisComposer = state
        }.store(in: &subscriptions)

        
    }
    
}
