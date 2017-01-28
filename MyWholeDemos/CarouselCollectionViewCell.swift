//
//  CarouselCollectionViewCell.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/11/30.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    func setupViews() {
        NSLog("init cell")
        containerView.layer.cornerRadius = containerView.bounds.width / 2
        containerView.layer.borderColor = UIColor.redColor().CGColor
        containerView.layer.borderWidth = 6
        containerView.layer.masksToBounds = true
    }

}
