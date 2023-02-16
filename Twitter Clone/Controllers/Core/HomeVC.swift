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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return UITableViewCell()
    }
    
    
}
