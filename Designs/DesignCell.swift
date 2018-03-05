//
//  DesignCell.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DesignCell: UICollectionViewCell {
    private let backgroundImageView: UIImageView = UIImageView()
    var image: UIImage? = nil {
        didSet {
            backgroundImageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        NSLayoutConstraint.activate(fillingContraints(for: backgroundImageView))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
