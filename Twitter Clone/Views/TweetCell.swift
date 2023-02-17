//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit


//MARK: - TweetCellDelegate protocol
protocol TweetCellDelegate: AnyObject {
    func tweetCellDidTapReply()
    func tweetCellDidTapRetweet()
    func tweetCellDidTapLike()
    func tweetCellDidTapShare()
}


class TweetCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "TweetCell"
    
    //MARK: - Delegate
    weak var delegate: TweetCellDelegate?
    
    //MARK: - Action Spacing
    private let actionSpacing: CGFloat = 45
    
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
    
    private let replyBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGray2
        return button
    }()
    
    private let retweetBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGray2
        return button
    }()
    
    private let likeBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGray2
        return button
    }()
    
    private let shareBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGray2
        return button
    }()
    
    
    //MARK: - Configure btns' actions
    private func configureBtnsActions() {
        replyBtn.addTarget(self, action: #selector(replyAction), for: .touchUpInside)
        retweetBtn.addTarget(self, action: #selector(retweetAction), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        shareBtn.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
    }
    
    //MARK: - Btns' Actions
    @objc private func replyAction() {
        delegate?.tweetCellDidTapReply()
    }
    @objc private func retweetAction() {
        delegate?.tweetCellDidTapRetweet()
    }
    @objc private func likeAction() {
        delegate?.tweetCellDidTapLike()
    }
    @objc private func shareAction() {
        delegate?.tweetCellDidTapShare()
    }
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // configure btns' actions
        configureBtnsActions()
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
        
        contentView.addSubview(replyBtn)
        contentView.addSubview(retweetBtn)
        contentView.addSubview(likeBtn)
        contentView.addSubview(shareBtn)
        
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
        ]
        
        // reply btn constraints
        let replyBtnConstraints = [
            replyBtn.leadingAnchor.constraint(equalTo: tweetTextContenLbl.leadingAnchor),
            replyBtn.topAnchor.constraint(equalTo: tweetTextContenLbl.bottomAnchor, constant: 10),
            replyBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        // retweet btn constraints
        let retweetBtnConstraints = [
            retweetBtn.leadingAnchor.constraint(equalTo: replyBtn.trailingAnchor, constant: actionSpacing),
            retweetBtn.centerYAnchor.constraint(equalTo: replyBtn.centerYAnchor)
        ]
        
        // like btn constraints
        let likeBtnConstraints = [
            likeBtn.leadingAnchor.constraint(equalTo: retweetBtn.trailingAnchor, constant: actionSpacing),
            likeBtn.centerYAnchor.constraint(equalTo: replyBtn.centerYAnchor)
        ]
        
        // share btn constraints
        let shareBtnConstraints = [
            shareBtn.leadingAnchor.constraint(equalTo: likeBtn.trailingAnchor, constant: actionSpacing),
            shareBtn.centerYAnchor.constraint(equalTo: replyBtn.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLblConstraints)
        NSLayoutConstraint.activate(usernameLblConstraints)
        NSLayoutConstraint.activate(tweetTextContentConstraints)
        
        NSLayoutConstraint.activate(replyBtnConstraints)
        NSLayoutConstraint.activate(retweetBtnConstraints)
        NSLayoutConstraint.activate(likeBtnConstraints)
        NSLayoutConstraint.activate(shareBtnConstraints)
        
    }
    
    
    
    

}
