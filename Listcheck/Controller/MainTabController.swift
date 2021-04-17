//
//  MainTabController.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/30/21.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        let todayLayout = UICollectionViewFlowLayout()
        let todayTab = templateNavigationController(title: "Today", unselectedImage: UIImage(systemName: "wallet.pass")!, selectedImage: UIImage(systemName: "wallet.pass.fill")!, rootViewController: TodayController(collectionViewLayout: todayLayout))
        
        let allLayout = UICollectionViewFlowLayout()
        let allTab = templateNavigationController(title: "All Tasks", unselectedImage: UIImage(systemName: "calendar.circle")!, selectedImage: UIImage(systemName: "calendar.circle.fill")!, rootViewController: AllTasksController(collectionViewLayout: allLayout))
        
        let settingsLayout = UICollectionViewFlowLayout()
        let settingsTab = templateNavigationController(title: "Settings", unselectedImage: UIImage(systemName: "gearshape")!, selectedImage: UIImage(systemName: "gearshape.fill")!, rootViewController: SettingsController(collectionViewLayout: settingsLayout))
        
        viewControllers = [todayTab, allTab, settingsTab]
        
        tabBar.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
    }
    
    func templateNavigationController(title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        nav.navigationBar.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        
        return nav
    }
}
