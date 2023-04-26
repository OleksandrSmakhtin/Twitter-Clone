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
final class RegisterViewViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isRegistrationFormValid: Bool = false
    @Published var user: User?
    
    
    // canceble to store
    private var subscriptions: Set<AnyCancellable> = []
    
    
    //MARK: - validation
    func validateRegistrationForm() {
        guard let email = email, let password = password else
        {
            isRegistrationFormValid = false
            return
        }
        isRegistrationFormValid = isValidEmail(email) && password.count >= 8
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
        AuthManager.shared.registerUser(with: email, password: password).sink { _ in
            
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions )

    }
    
    
}
