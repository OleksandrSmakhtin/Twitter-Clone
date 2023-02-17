//
//  ProfileTableHeaderView.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

class ProfileHeader: UIView {

    //MARK: - UI Components
    private let displayNameLbl: UILabel = {
        let label = UILabel()
        label.text = "Alex Rame"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLbl: UILabel = {
        let label = UILabel()
        label.text = "@owslyashaa"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLbl: UILabel = {
        let label = UILabel()
        label.text = "I'm a young begginer IOS developer."
        label.numberOfLines = 3
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let joinedDateLbl: UILabel = {
        let label = UILabel()
        label.text = "Joined: May 2021"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let joinedDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileHeadeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "header")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        
    }
    
    //MARK: - Required Init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        addSubview(profileHeadeImageView)
        addSubview(avatarImageView)
        addSubview(displayNameLbl)
        addSubview(usernameLbl)
        addSubview(bioLbl)
        addSubview(joinedDateImageView)
        addSubview(joinedDateLbl)
    }
    
    //MARK: - Apply Constraints
    private func applyConstraints() {
        // profile header image constraints
        let profileHeaderImageViewConstraints = [
            profileHeadeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeadeImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeadeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeadeImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        // avatar image constraints
        let avatarImageViewConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarImageView.centerYAnchor.constraint(equalTo: profileHeadeImageView.bottomAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        // display name lbl constraints
        let displayNameLblConstraints = [
            displayNameLbl.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            displayNameLbl.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20)
        ]
        
        // username lbl constraints
        let usernameLblConstraints = [
            usernameLbl.leadingAnchor.constraint(equalTo: displayNameLbl.leadingAnchor),
            usernameLbl.topAnchor.constraint(equalTo: displayNameLbl.bottomAnchor, constant: 5)
        ]
        
        // bio lbl constraints
        let bioLblConstraints = [
            bioLbl.leadingAnchor.constraint(equalTo: displayNameLbl.leadingAnchor),
            bioLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bioLbl.topAnchor.constraint(equalTo: usernameLbl.bottomAnchor, constant: 5)
        ]
        
        // joined date image view constraints
        let joinedDateImageViewConstraints = [
            joinedDateImageView.leadingAnchor.constraint(equalTo: displayNameLbl.leadingAnchor),
            joinedDateImageView.topAnchor.constraint(equalTo: bioLbl.bottomAnchor, constant: 5)
        ]
        
        // joined date lbl constraints
        let joinedDateLblConstraints = [
            joinedDateLbl.leadingAnchor.constraint(equalTo: joinedDateImageView.trailingAnchor, constant: 2),
            joinedDateLbl.bottomAnchor.constraint(equalTo: joinedDateImageView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLblConstraints)
        NSLayoutConstraint.activate(usernameLblConstraints)
        NSLayoutConstraint.activate(bioLblConstraints)
        NSLayoutConstraint.activate(joinedDateImageViewConstraints)
        NSLayoutConstraint.activate(joinedDateLblConstraints)
        
    }

}
