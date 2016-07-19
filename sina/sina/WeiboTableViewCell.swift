//
//  WeiboTableViewCell.swift
//  sina
//
//  Created by 黄 家金 on 16/7/13.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit
protocol WeiboTableViewCellDelegate {
    func touchSourceLable(cell:WeiboTableViewCell,sourceLabel:UILabel,location:CGPoint,indexPath:NSIndexPath)
}
class WeiboTableViewCell: UITableViewCell {
    var delegate:WeiboTableViewCellDelegate?
    var indexPath:NSIndexPath?
    @IBOutlet weak var HeadImageView: UIImageView!
    @IBOutlet weak var reposButton: UIButton!
    @IBAction func repostAction(sender: UIButton) {
        print("repost")
    }
    @IBOutlet weak var commentButton: UIButton!
    @IBAction func commentAction(sender: UIButton) {
        print("comment")
    }
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeAction(sender: UIButton) {
        print("like")
    }
    @IBOutlet weak var nickeNameLabel: UILabel!
    
    @IBOutlet weak var publishTextlabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        
      
        super.awakeFromNib()
        // Initialization code
        
        self.HeadImageView.layer.cornerRadius=20
        self.HeadImageView.layer.masksToBounds=true
        let headerTap=UITapGestureRecognizer(target: self, action: #selector(WeiboTableViewCell.HeaderTapAction(_:)))
        self.HeadImageView.userInteractionEnabled=true
        self.HeadImageView.addGestureRecognizer(headerTap)
        
        self.nickeNameLabel.userInteractionEnabled=true
        self.nickeNameLabel.addGestureRecognizer(headerTap)
        
        let sourceTayp = UITapGestureRecognizer(target: self, action: #selector(WeiboTableViewCell.sourceTapAction(_:)))
        
       
        self.sourceLabel.userInteractionEnabled = true
        self.sourceLabel.addGestureRecognizer(sourceTayp)
        
        
        
    }
    
    func sourceTapAction (sender:UITapGestureRecognizer){
        print("点击了发布来源")
        
        if self.delegate != nil {
            let location =  sender.locationInView(sender.view)
            self.delegate?.touchSourceLable(self, sourceLabel: self.sourceLabel, location: location,indexPath: indexPath!)
        }
    }
    
    func HeaderTapAction(sender:UITapGestureRecognizer){
        print("点击了用户头像")
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
      
}
