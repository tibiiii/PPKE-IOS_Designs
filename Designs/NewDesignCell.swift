//
//  NewDesignCell.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class NewDesignCell: DashboardCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "new_cell"))
        imageView.tintColor = UIColor.ppkeBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalToConstant: 60.0),
                                     imageView.heightAnchor.constraint(equalToConstant: 60.0),
                                     imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.ppkeGrey.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
