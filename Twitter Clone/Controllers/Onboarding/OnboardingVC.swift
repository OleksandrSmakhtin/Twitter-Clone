//
//  OnboardingVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 25.04.2023.
//

import UIKit

class OnboardingVC: UIViewController {
    
    //MARK: - UI Objects
    private let welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "See what's happening in the world right now."
        lbl.textAlignment = .center
        lbl.textColor = .label
        lbl.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let createAccountBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create account", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        btn.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let promptLbl: UILabel = {
        let lbl = UILabel()
        lbl.tintColor = .gray
        lbl.text = "Have an account already?"
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapCreateAccount() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(welcomeLbl)
        view.addSubview(createAccountBtn)
        view.addSubview(promptLbl)
        view.addSubview(loginBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        // welcomeLbl constraints
        let welcomeLblConstraints = [
            welcomeLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        // createAccountBtn constraints
        let createAccountBtnConstraints = [
            createAccountBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountBtn.topAnchor.constraint(equalTo: welcomeLbl.bottomAnchor, constant: 20),
            createAccountBtn.widthAnchor.constraint(equalTo: welcomeLbl.widthAnchor),
            createAccountBtn.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        // promptLbl constraints
        let promptLblConstraints = [
            promptLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        // loginBtn constraints
        let loginBtnConstraints = [
            loginBtn.centerYAnchor.constraint(equalTo: promptLbl.centerYAnchor),
            loginBtn.leadingAnchor.constraint(equalTo: promptLbl.trailingAnchor, constant: 10)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(welcomeLblConstraints)
        NSLayoutConstraint.activate(createAccountBtnConstraints)
        NSLayoutConstraint.activate(promptLblConstraints)
        NSLayoutConstraint.activate(loginBtnConstraints)
    }


}
