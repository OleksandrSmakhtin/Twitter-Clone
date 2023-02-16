//
//  MainTabBarC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 16.02.2023.
//

import UIKit

class MainTabBarC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let vc2 = UINavigationController(rootViewController: SearchVC())
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let vc3 = UINavigationController(rootViewController: NotificationsVC())
        vc3.tabBarItem.image = UIImage(systemName: "bell")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        let vc4 = UINavigationController(rootViewController: MessagesVC())
        vc4.tabBarItem.image = UIImage(systemName: "envelope")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }

}
