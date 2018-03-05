//
//  DiscoverViewController.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    private struct Constants {
        static let title: String = "Learn"
    }
    
    let headerView: DashboardHeaderview = {
        let hv = DashboardHeaderview()
        hv.titleLabel.text = Constants.title
        return hv
    }()
    
    override func loadView() {
        view = UIView()
        
        var constraints: [NSLayoutConstraint] = []
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        constraints.append(contentsOf: [headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        headerView.topAnchor.constraint(equalTo: view.topAnchor),
                                        headerView.heightAnchor.constraint(equalToConstant: headerView.height)])
        NSLayoutConstraint.activate(constraints)
    }
}
