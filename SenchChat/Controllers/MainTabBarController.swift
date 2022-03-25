//
//  MainTabBarController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 25.02.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    private let currentUser: MUser
    
    init(currentUser: MUser = MUser(userName: "poxos",
                                    phoneNumber: "093",
                                    email: "aa",
                                    avatarStringURL: "as",
                                    sex: "as", id: "As",
                                    description: "as")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.dismissKeyboard()
        let listVC = ListViewController(currentUser: currentUser)
        let peopleVC = PeopleViewController(currentUser: currentUser)
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
        viewControllers = [ generateNavigationController(rootViewController: peopleVC, title: "People", image: convImage!),
                            generateNavigationController(rootViewController: listVC, title: "Conversations", image: peopleImage!)
                            
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
