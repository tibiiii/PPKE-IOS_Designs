//
//  DashboardCell.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DashboardCell: UICollectionViewCell {
    private struct Constants {
        static let cornerRadius: CGFloat = 16.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
