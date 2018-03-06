//
//  DashboardHeaderview.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DashboardHeaderview: UIView {
    private struct Constants {
        static let titlePadding: CGPoint = CGPoint(x: 52.0, y: -42.0)
        static let height: CGFloat = 120.0
    }
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 40.0, weight: UIFont.Weight.bold)
        return l
    }()
    
    var height: CGFloat { return Constants.height }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titlePadding.x),
                                     titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.titlePadding.y)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

