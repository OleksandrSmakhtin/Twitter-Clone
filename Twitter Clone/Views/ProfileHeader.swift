//
//  ProfileTableHeaderView.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

class ProfileHeader: UIView {
    
    //MARK: - Enum
    private enum SectionTabs: String {
        case tweets = "Tweets"
        case tweetsAndReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .tweets:
                return 0
            case .tweetsAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
        
    }
    
    //MARK: - Vars
    private var selectedTab = 0 {
        didSet {
            print(selectedTab)
        }
    }

    //MARK: - UI Components
    private let tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"].map { btnTitle in
        let button = UIButton(type: .system)
        button.setTitle(btnTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // lazy means that all properties will be available when the view is initialized
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let followersTextLbl: UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followersCountLbl: UILabel = {
        let label = UILabel()
        label.text = "45"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followingTextLbl: UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followingCountLbl: UILabel = {
        let label = UILabel()
        label.text = "314"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    //MARK: - Configure Stack Btns
    private func configureStackBtns() {
        for (i, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    //MARK: - Tabs Actions
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        
        switch label {
        case SectionTabs.tweets.rawValue:
            selectedTab = 0
        case SectionTabs.tweetsAndReplies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // configure stack btns
        configureStackBtns()
        
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
        addSubview(followingCountLbl)
        addSubview(followingTextLbl)
        addSubview(followersCountLbl)
        addSubview(followersTextLbl)
        addSubview(sectionStack)
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
        
        // following count lbl constraints
        let followingCountLblConstraints = [
            followingCountLbl.leadingAnchor.constraint(equalTo: displayNameLbl.leadingAnchor),
            followingCountLbl.topAnchor.constraint(equalTo: joinedDateLbl.bottomAnchor, constant: 10)
        ]
        
        // following text lbl constraints
        let followingTextLblConstraints = [
            followingTextLbl.leadingAnchor.constraint(equalTo: followingCountLbl.trailingAnchor, constant: 4),
            followingTextLbl.bottomAnchor.constraint(equalTo: followingCountLbl.bottomAnchor)
        ]
        
        // followers count lbl constraints
        let followersCountLblConstraints = [
            followersCountLbl.leadingAnchor.constraint(equalTo: followingTextLbl.trailingAnchor, constant: 8),
            followersCountLbl.bottomAnchor.constraint(equalTo: followingCountLbl.bottomAnchor)
        ]
        
        //followers text lbl constraints
        let followersTextLblConstraints = [
            followersTextLbl.leadingAnchor.constraint(equalTo: followersCountLbl.trailingAnchor, constant: 4),
            followersTextLbl.bottomAnchor.constraint(equalTo: followingCountLbl.bottomAnchor)
        ]
        
        // section stack constraints
        let sectionStackConstraints = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionStack.topAnchor.constraint(equalTo: followingCountLbl.bottomAnchor, constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLblConstraints)
        NSLayoutConstraint.activate(usernameLblConstraints)
        NSLayoutConstraint.activate(bioLblConstraints)
        NSLayoutConstraint.activate(joinedDateImageViewConstraints)
        NSLayoutConstraint.activate(joinedDateLblConstraints)
        NSLayoutConstraint.activate(followingCountLblConstraints)
        NSLayoutConstraint.activate(followingTextLblConstraints)
        NSLayoutConstraint.activate(followersCountLblConstraints)
        NSLayoutConstraint.activate(followersTextLblConstraints)
        NSLayoutConstraint.activate(sectionStackConstraints)
        
    }

}
