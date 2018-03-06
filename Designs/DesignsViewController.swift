//
//  DesignsViewController.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DesignsViewController: UIViewController {
    private struct Constants {
        static let title: String = "Designs"
    }
    
    let data: [DesignData] = [DesignData(name: "Design 0", image: #imageLiteral(resourceName: "designThumbnail0")),
                              DesignData(name: "Design 1", image: #imageLiteral(resourceName: "designThumbnail1")),
                              DesignData(name: "Watch", image: #imageLiteral(resourceName: "designThumbnail2")),
                              DesignData(name: "Ring", image: #imageLiteral(resourceName: "designThumbnail3")),
                              DesignData(name: "Spring", image: #imageLiteral(resourceName: "designThumbnail4")),
                              DesignData(name: "Skyscraper", image: #imageLiteral(resourceName: "designThumbnail5")),
                              DesignData(name: "Map", image: #imageLiteral(resourceName: "designThumbnail6"))]
    
    let headerView: DashboardHeaderview = {
        let hv = DashboardHeaderview()
        hv.titleLabel.text = Constants.title
        return hv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200.0, height: 200.0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.gray
        return cv
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

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(collectionView, belowSubview: headerView)
        constraints.append(contentsOf: [collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }    
}

extension IndexPath {
    var isNewDesign: Bool { return item == 0 }
}
