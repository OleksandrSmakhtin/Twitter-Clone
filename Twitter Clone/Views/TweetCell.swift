//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

class TweetCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "TweetCell"
    
    //MARK: - UI Components
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let displayNameLbl: UILabel = {
        let label = UILabel()
        label.text = "My name"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLbl: UILabel = {
        let label = UILabel()
        label.text = "@Sir"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tweetTextContenLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This is my Mockup tweet, and it is going to take as many lines as possible. I believe some more text is enpught but let's add some more anyway... Bruh!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLbl)
        contentView.addSubview(usernameLbl)
        contentView.addSubview(tweetTextContenLbl)
    }
    
    //MARK: - Apply Constraints
    private func applyConstraints() {
        // avatar constraints
        let avatarImageViewConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        // display name constaints
        let displayNameLblConstraints = [
            displayNameLbl.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            displayNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ]
        
        // usernameLblConstraints
        let usernameLblConstraints = [
            usernameLbl.leadingAnchor.constraint(equalTo: displayNameLbl.trailingAnchor, constant: 10),
            usernameLbl.centerYAnchor.constraint(equalTo: displayNameLbl.centerYAnchor)
        ]
        
        // tweetTextContentConstraints
        let tweetTextContentConstraints = [
            tweetTextContenLbl.leadingAnchor.constraint(equalTo: displayNameLbl.leadingAnchor),
            tweetTextContenLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            tweetTextContenLbl.topAnchor.constraint(equalTo: displayNameLbl.bottomAnchor, constant: 10),
            tweetTextContenLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLblConstraints)
        NSLayoutConstraint.activate(usernameLblConstraints)
        NSLayoutConstraint.activate(tweetTextContentConstraints)
        
    }
    
    
    
    

}
