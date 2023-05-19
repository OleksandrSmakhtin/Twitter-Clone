//
//  TweetComposeVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 19.05.2023.
//

import UIKit

class TweetComposeVC: UIViewController {

    
    
    
    //MARK: - UI Objects
    private let tweetBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlueColor
        btn.setTitle("Tweet", for: .normal)
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(tweetBtn)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        //tweetBtn Constraints
        let tweetBtnConstraints = [
            tweetBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetBtn.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetBtn.widthAnchor.constraint(equalToConstant: 120),
            tweetBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(tweetBtnConstraints)
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    //MARK: - Actions
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }


}
