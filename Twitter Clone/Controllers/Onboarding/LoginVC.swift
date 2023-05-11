//
//  LoginVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 11.05.2023.
//

import UIKit
import Combine

class LoginVC: UIViewController {

    //MARK: - Set view model
    private var viewModel = AuthViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let loginTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Login to your account"
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
        )
        textField.addTarget(self, action: #selector(didChangeEmail), for: .editingChanged)
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
        )
        textField.addTarget(self, action: #selector(didChangePassword), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.isEnabled = false
        
        return btn
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // bind views
        bindViews() 
        
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // bind validation
        viewModel.$isAuthFormValid.sink { [weak self] validationState in
            self?.loginBtn.isEnabled = validationState
        }.store(in: &subscriptions)
        
        
        // bind registration
        viewModel.$user.sink { [weak self] user in
            
            guard user != nil else { return }
            guard let vc = self?.navigationController?.viewControllers.first as? OnboardingVC else { return }
            vc.dismiss(animated: true)
            
        }.store(in: &subscriptions)
        
    } 
    
    //MARK: - Actions
    @objc private func didChangeEmail() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthForm()
    }
    @objc private func didChangePassword() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthForm()
    }
    @objc private func didTapLogin() {
        
    }
    @objc private func didTapToDissmiss() {
        view.endEditing(true)
    }

    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(loginTitleLbl)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginBtn)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDissmiss)))
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        // loginTitleLbl constraints
        let loginTitleLblConstraints = [
            loginTitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ]
        
        // emailTextField constraints
        let emailTextFieldConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: loginTitleLbl.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        // passwordTextField constraints
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        // loginBtn constraints
        let loginBtnConstraints = [
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginBtn.widthAnchor.constraint(equalToConstant: 180),
            loginBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(loginTitleLblConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(loginBtnConstraints)
        
    }

}
