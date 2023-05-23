//
//  HomeVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit
import Combine
import FirebaseAuth

class HomeVC: UIViewController {
    
    
    //MARK: - ViewModel
    private var viewModel = HomeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Components
    private lazy var composeTweetBtn: UIButton = {
        let btn = UIButton(type: .system, primaryAction: UIAction { [weak self] _ in self?.didTapTweet()})
        btn.backgroundColor = .twitterBlueColor
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)), for: .normal)
        btn.layer.cornerRadius = 30
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let timeLineTable: UITableView = {
        let table = UITableView()
        table.register(TweetCell.self, forCellReuseIdentifier: TweetCell.identifier)
        return table
    }()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // adding subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply table delegates
        applyTableDeleagtes()
        // configure nav bar
        configureNavBar()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        // handle auth
        handleAuth()
        // get user
        viewModel.retreiveUser()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
        }.store(in: &subscriptions)
        
        viewModel.$tweets.sink { [weak self] tweets in
            DispatchQueue.main.async { 
                self?.timeLineTable.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Complete user onborading
    private func completeUserOnboarding() {
        let vc = ProfileDataFormVC()
        present(vc, animated: true)
    }
    
    
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTable.frame = view.bounds
    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(timeLineTable)
        view.addSubview(composeTweetBtn)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        // composeTweetBtn Constraints
        let composeTweetBtnConstraints = [
            composeTweetBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            composeTweetBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            composeTweetBtn.widthAnchor.constraint(equalToConstant: 60),
            composeTweetBtn.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(composeTweetBtnConstraints)
    }
    
    
    //MARK: - Handle auth
    private func handleAuth() {
        // handle firebas auth
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    //MARK: - Navigate to tweet
    private func didTapTweet() {
        let vc = UINavigationController(rootViewController: TweetComposeVC())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //MARK: - Configure NavBar
    private func configureNavBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitterLogo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(profileAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), style: .plain, target: self, action: #selector(signOutAction))
    }
    
    //MARK: - Nav Bar Actions
    @objc private func signOutAction() {
        // firebase sign out
        try? Auth.auth().signOut()
        handleAuth()
    }
    
    @objc private func profileAction() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - UITableViewDelegate & DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyTableDeleagtes() {
        timeLineTable.delegate = self
        timeLineTable.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier) as? TweetCell else { return UITableViewCell()}
        
        let tweetModel = viewModel.tweets[indexPath.row]
        
        cell.configure(displayName: tweetModel.author.displayName, username: tweetModel.author.username, tweetContent: tweetModel.tweetContent, avatarPath: tweetModel.author.avatarPath)
        
        // apply delegate
        cell.delegate = self
        
        return cell
    }
}



//MARK: - TweetCellDelegate
extension HomeVC: TweetCellDelegate {
    func tweetCellDidTapReply() {
        print("Reply tapped")
    }
    
    func tweetCellDidTapRetweet() {
        print("Retweet tapped")
    }
    
    func tweetCellDidTapLike() {
        print("Like tapped")
    }
    
    func tweetCellDidTapShare() {
        print("Share tapped")
    }
    
    
}
