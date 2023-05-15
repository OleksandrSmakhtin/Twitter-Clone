//
//  ProfileDataFormViewViewModel.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 14.05.2023.
//

import Foundation
import Combine
import UIKit
import FirebaseStorage
import FirebaseStorageCombineSwift


final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var error: String = ""
    @Published var url: URL?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    // form validation
    func validateUserProfileForm() {
        guard let displayName = displayName, displayName.count > 2,
                let username = username, username.count > 2,
                let bio = bio, bio.count > 2, imageData != nil else {
            isFormValid = false
            return }
        
        isFormValid = true
    }
    
    func uploadAvatar() {
        
        let randomId = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "images/jpeg"
        
        StorageManager.shared.uploadProfilePhoto(with: randomId, image: imageData, metaData: metaData)
            .flatMap({ metaData in
                StorageManager.shared.getDownloadURL(for: metaData.path)
        })
            .sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] url in
            self?.url = url
        }.store(in: &subscriptions)

    }
    
    
}
