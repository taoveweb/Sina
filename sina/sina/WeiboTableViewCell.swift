//
//  WeiboTableViewCell.swift
//  sina
//
//  Created by 黄 家金 on 16/7/13.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit

class WeiboTableViewCell: UITableViewCell {

    @IBOutlet weak var HeadImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.HeadImageView.layer.cornerRadius=20
        self.HeadImageView.layer.masksToBounds=true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
