//
//  ProfileVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    //MARK: - UI Components
    private let profileTable: UITableView = {
        let table = UITableView()
        table.register(TweetCell.self, forCellReuseIdentifier: TweetCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure view
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        // add subviews
        addSubviews()
        
        let headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: profileTable.frame.width, height: 380))
        profileTable.tableHeaderView = headerView
        
        
        
        
        
        // apply constraints
        applyConstraints()
        // apply table delegates
        applyTableDelegates()
        
        
        
        
    }
    
    
    
    
    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(profileTable)
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
        
        NSLayoutConstraint.activate(profileTableConstraints)
    }


}



//MARK: - UITableViewDelegate & DataSource
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyTableDelegates() {
        profileTable.delegate = self
        profileTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier) as? TweetCell else { return UITableViewCell()}
        
        
        
        return cell
        
    }
    
    
}
