//
//  DesignCell.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DesignCell: DashboardCell {
    private struct Constants {
        struct Shadow {
            static let opacity: Float = 0.16
            static let color: CGColor = UIColor.black.cgColor
            static let offset: CGSize = CGSize(width: 0.0, height: 16)
            static let radius: CGFloat = 16.0
        }
    }

    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    var image: UIImage? = nil {
        didSet {
            backgroundImageView.image = image
        }
    }
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.bold)
        return l
    }()
    var title: String? = nil {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var constraints: [NSLayoutConstraint] = []
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)
        constraints.append(contentsOf: contentView.fillingContraints(for: backgroundImageView))
        
        let bottomBar = UIView()
        bottomBar.backgroundColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.addSubview(titleLabel)
        constraints.append(contentsOf: [titleLabel.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 8.0),
                                        titleLabel.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -8.0),
                                        titleLabel.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor)])
        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomBar)
        constraints.append(contentsOf: [bottomBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                        bottomBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                        bottomBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                        bottomBar.heightAnchor.constraint(equalToConstant: 44.0)])
        
        
        NSLayoutConstraint.activate(constraints)
        
        layer.masksToBounds = false
        layer.shadowColor = Constants.Shadow.color
        layer.shadowOpacity = Constants.Shadow.opacity
        layer.shadowOffset = Constants.Shadow.offset
        layer.shadowRadius = Constants.Shadow.radius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
