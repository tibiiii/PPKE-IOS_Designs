//
//  DashboardViewController.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DashboardViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let discoverViewController = DiscoverViewController()
        discoverViewController.tabBarItem = UITabBarItem(title: "Discover", image: nil, selectedImage: nil)
        let designsViewController = DesignsViewController()
        designsViewController.tabBarItem = UITabBarItem(title: "Designs", image: nil, selectedImage: nil)
        let learnViewController = LearnViewController()
        learnViewController.tabBarItem = UITabBarItem(title: "Learn", image: nil, selectedImage: nil)
        viewControllers = [discoverViewController,
                           designsViewController,
                           learnViewController]
        selectedIndex = 1
    }
}
