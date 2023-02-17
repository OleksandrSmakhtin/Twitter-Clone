//
//  ProfileVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    //MARK: - Status bar settings
    private var isStatusBarHidden = true
    
    private let statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        return view
    }()
    
    
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
    }
    
    //MARK: - configure profile Table
    private func configureTable() {
        let headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: profileTable.frame.width, height: 380))
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier) as? TweetCell else { return UITableViewCell()}
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
