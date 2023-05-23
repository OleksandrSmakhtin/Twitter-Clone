//
//  ProfileVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit
import Combine
import SDWebImage

class ProfileVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = ProfileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Status bar settings
    private var isStatusBarHidden = true
    
    
    //MARK: - UI Components
    
    private let statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        return view
    }()
    
    private let profileTable: UITableView = {
        let table = UITableView()
        table.register(TweetCell.self, forCellReuseIdentifier: TweetCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: profileTable.frame.width, height: 380))
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure view
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        // configure nav bar
        navigationController?.navigationBar.isHidden = true
        // add subviews
        addSubviews()
        // configure profile table
        configureTable()
        // apply constraints
        applyConstraints()
        // apply table delegates
        applyTableDelegates()
        // bind views
        bindViews()
    }
    
    
    //MARK: - viewDidAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retreiveUser()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            self?.headerView.displayNameLbl.text = user.displayName
            self?.headerView.usernameLbl.text = "@\(user.username)"
            self?.headerView.bioLbl.text = user.bio
            self?.headerView.followersCountLbl.text = "\(user.followersCount)"
            self?.headerView.followingCountLbl.text = "\(user.followingCount)"
            self?.headerView.avatarImageView.sd_setImage(with: URL(string: user.avatarPath))
            self?.headerView.joinedDateLbl.text = self?.viewModel.getFormattedData(with: user.createdOn)
            
        }.store(in: &subscriptions)
        
        viewModel.$tweets.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.profileTable.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - configure profile Table
    private func configureTable() {
        profileTable.tableHeaderView = headerView
        
        // ignore the safe area for the table
        profileTable.contentInsetAdjustmentBehavior = .never
    }
    
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(profileTable)
        view.addSubview(statusBar)
    }
    
    //MARK: - Apply Constraints
    private func applyConstraints() {
        // profile table constraints
        let profileTableConstraints = [
            profileTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTable.topAnchor.constraint(equalTo: view.topAnchor),
            profileTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        // status bar constraints
        let statusBarConstraints = [
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // set height dependig from iphone type
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20)
        ]
        
        NSLayoutConstraint.activate(profileTableConstraints)
        NSLayoutConstraint.activate(statusBarConstraints)
    }


}



//MARK: - UITableViewDelegate & DataSource
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyTableDelegates() {
        profileTable.delegate = self
        profileTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier) as? TweetCell else { return UITableViewCell()}
        
        let tweetModel = viewModel.tweets[indexPath.row]
        
        cell.configure(displayName: tweetModel.author.displayName, username: tweetModel.author.username, tweetContent: tweetModel.tweetContent, avatarPath: tweetModel.author.avatarPath)
        
        
        return cell
        
    }
    
    
    //MARK: - ScrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition > 150 && isStatusBarHidden {
            
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }

        } else if yPosition < 0 && !isStatusBarHidden{
            
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
            
        }
        
    }
    
    
}
