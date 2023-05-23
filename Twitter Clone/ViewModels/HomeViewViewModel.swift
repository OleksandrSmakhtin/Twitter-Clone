//
//  HomeViewViewModel.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 14.05.2023.
//

import Foundation
import Combine
import FirebaseAuth


final class HomeViewViewModel: ObservableObject {
    
    @Published var user: TwitterUser?
    @Published var error: String?
    @Published var tweets: [Tweet] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func retreiveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: id)
            .handleEvents(receiveOutput: { [weak self] user in
                // calls as soon as we get the user
                self?.user = user
                self?.fetchTweets()
            })
            .sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions)
    }
    
    func fetchTweets() {
//        guard let id = user?.id else { return }
//        DatabaseManager.shared.collectionTweets(retreiveTweets: id).sink { [weak self] completion in
//            if case .failure(let error) = completion {
//                self?.error = error.localizedDescription
//            }
//        } receiveValue: { [weak self] retreivedTweets in
//            self?.tweets = retreivedTweets
//        }.store(in: &subscriptions)
        
        
        DatabaseManager.shared.collectionTweets().sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] tweets in
            self?.tweets = tweets
        }.store(in: &subscriptions)

        

    }
    
}
