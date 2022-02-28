//
//  MainTabBarController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 25.02.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        let listVC = ListViewController()
        let peopleVC = PeopleViewController()
        let boldConfig = UIImage.SymbolConfiguration(weight:.medium)
        let peopleImage = UIImage(systemName: "bubble.left.and.bubble.right",withConfiguration:boldConfig)
        let convImage = UIImage(systemName: "person.2",withConfiguration:boldConfig)
        let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
        if self.traitCollection.userInterfaceStyle == .dark {
            appearance.backgroundColor = .black
        }else {
                appearance.backgroundColor = .white
             }
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        viewControllers = [ generateNavigationController(rootViewController: listVC, title: "Conversations", image: peopleImage!),
                            generateNavigationController(rootViewController: peopleVC, title: "People", image: convImage!)
        ]
        
        
        
        
    }
    private func generateNavigationController(rootViewController:UIViewController,
                                              title: String,
                                              image:UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
