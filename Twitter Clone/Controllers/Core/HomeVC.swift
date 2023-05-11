//
//  HomeVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {
    
    
    //MARK: - UI Components
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
        // apply table delegates
        applyTableDeleagtes()
        // configure nav bar
        configureNavBar()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        handleAuth()
        
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTable.frame = view.bounds
    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(timeLineTable)
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
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier) as? TweetCell else { return UITableViewCell()}
        
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
