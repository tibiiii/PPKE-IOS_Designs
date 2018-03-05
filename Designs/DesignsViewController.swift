//
//  DesignsViewController.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DesignsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private struct Constants {
        static let title: String = "Designs"
        static let newDesignCellReuseId: String = "NewDesignCellId"
        static let designCellReuseId: String = "DesignCellId"
        static let padding: CGFloat = 52.0
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 120.0, left: Constants.padding, bottom: 0.0, right: Constants.padding)
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
        let layout = SizeChangingFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.register(NewDesignCell.self, forCellWithReuseIdentifier: Constants.newDesignCellReuseId)
        cv.register(DesignCell.self, forCellWithReuseIdentifier: Constants.designCellReuseId)
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.contentInset = Constants.contentInset
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
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.isNewDesign {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.newDesignCellReuseId, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.designCellReuseId, for: indexPath) as! DesignCell
            let currentData = data[indexPath.row % data.count]
            cell.image = currentData.image
            cell.title = currentData.name
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnNumber: CGFloat = 3.0
        let width = collectionView.bounds.size.width - collectionView.contentInset.left - collectionView.contentInset.right - (columnNumber - 1) * Constants.padding
        return CGSize(width: width / 3.0, height: 254.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }
}

extension IndexPath {
    var isNewDesign: Bool { return item == 0 }
}

class SizeChangingFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView!.bounds.width != newBounds.width
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        let shouldInvalidate = collectionView!.bounds.size.width != newBounds.width
        context.invalidateFlowLayoutDelegateMetrics = shouldInvalidate
        context.invalidateFlowLayoutAttributes = shouldInvalidate
        return context
    }
}
