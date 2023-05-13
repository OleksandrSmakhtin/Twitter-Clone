//
//  RegisterViewViewModel.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 25.04.2023.
//

import Foundation
import Firebase
import Combine



                                   // make a class observable
final class AuthViewViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    
    
    // cancellable to store
    private var subscriptions: Set<AnyCancellable> = []
    
    
    //MARK: - validation
    func validateAuthForm() {
        guard let email = email, let password = password else
        {
            isAuthFormValid = false
            return
        }
        isAuthFormValid = isValidEmail(email) && password.count >= 8
    }
    
    //MARK: - Email validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: - Create user
    func createUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.registerUser(with: email, password: password)
            // handle user output
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
        })
            
            .sink { [weak self] completion in
            // handle errors
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
            // handle firestore
        } receiveValue: { [weak self] user in
            self?.createUserRecord(for: user)
        }.store(in: &subscriptions )
    }
    
    //MARK: - Create user record
    private func createUserRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user).sink { comletion in
            if case .failure(let error) = comletion {
                self.error = error
            }
        } receiveValue: { <#Bool#> in
            <#code#>
        }

    }
    
    
    //MARK: - Login user
    func loginUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.loginUser(with: email, password: password).sink { [weak self] completion in
            // handle errors
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions )
    }
    
    
}
