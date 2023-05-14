//
//  ProfileDataFormViewViewModel.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 14.05.2023.
//

import Foundation
import Combine


final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    
    
}
