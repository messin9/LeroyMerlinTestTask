//
//  TabBarController.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 20.04.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    private func configureController(_ viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navBarController = UINavigationController(rootViewController: rootViewController)
        return configureController(navBarController, title: title, image: image)
    }
    

    
    func setupTabBarVC() {
        let main = MainController()
        let myList = MyListViewController()
        let shops = ShopsController()
        let profile = ProfileController()
        let cart = CartController()
        tabBar.barTintColor = .white
        tabBar.tintColor = .systemGreen
        tabBar.alpha = 1
        
        viewControllers = [
            setupNavigationController(rootViewController: main, title: "Главная", image: #imageLiteral(resourceName: "search")),
            configureController(myList, title: "Мой список", image: #imageLiteral(resourceName: "myList")),
            configureController(shops, title: "Магазины", image: #imageLiteral(resourceName: "shops")),
            configureController(profile, title: "Профиль", image: #imageLiteral(resourceName: "profile")),
            configureController(cart, title: "Корзина", image: #imageLiteral(resourceName: "cart"))
        ]
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarVC()
    }
}
