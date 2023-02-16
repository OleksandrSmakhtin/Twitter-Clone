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
        

    }
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(timeLineTable)
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTable.frame = view.bounds
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
