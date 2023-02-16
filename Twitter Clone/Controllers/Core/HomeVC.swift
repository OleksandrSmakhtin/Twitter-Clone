//
//  HomeVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

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
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTable.frame = view.bounds
    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(timeLineTable)
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
    }
    
    //MARK: - Nav Bar Actions
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
