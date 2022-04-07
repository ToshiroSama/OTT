//
//  ViewController.swift
//  OTT
//
//  Created by Alisher Djuraev on 18/03/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UserViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "person")
        
        vc1.title = "Главная"
        vc2.title = "Профиль"
        
        // Customization of tabBar's properties
        tabBar.backgroundColor = .black
        tabBar.tintColor = UIColor.rgb(red: 153, green: 255, blue: 102)
        tabBar.unselectedItemTintColor = UIColor(white: 1.0, alpha: 1.0)
        
        setViewControllers([vc1, vc2], animated: true)
    }


}

