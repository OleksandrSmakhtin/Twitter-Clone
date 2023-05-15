//
//  StorageManager.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 15.05.2023.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

enum FirestorageErrors: Error {
    case invalidImgId
}

final class StorageManager {
    
    static let shared = StorageManager()
    
    let storage = Storage.storage()
    
    
    // get download url
    func getDownloadURL(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else { return Fail(error: FirestorageErrors.invalidImgId).eraseToAnyPublisher()}
        
        return storage.reference(withPath: id).downloadURL().print().eraseToAnyPublisher()
    }
    
    // upload photo
    func uploadProfilePhoto(with randomId: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        // store photo to firebase storage by path
        return storage.reference().child("images/\(randomId).jpg").putData(image, metadata: metaData).print().eraseToAnyPublisher()
    }
    
    
}
