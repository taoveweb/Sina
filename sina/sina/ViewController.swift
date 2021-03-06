//
//  ViewController.swift
//  sina
//
//  Created by 淘未 on 16/7/12.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WeiboTableViewCellDelegate {
    
    var  myTableView:UITableView!
    var dataSource = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.myTableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height), style: .Plain)
        
        self.view.addSubview(self.myTableView)
        
        self.myTableView.delegate=self
        self.myTableView.dataSource=self
        self.myTableView.rowHeight=440
        
        
//        self.myTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        
        
        let nib = UINib(nibName: "WeiboTableViewCell", bundle: NSBundle.mainBundle())
        self.myTableView.registerNib(nib, forCellReuseIdentifier: "cellID")

        //表头
        let tableHeader=UILabel(frame: CGRectMake(0,0,self.view.frame.size.width,60))
            tableHeader.text="我是表视图表头"
            tableHeader.textAlignment=NSTextAlignment.Center
            tableHeader.backgroundColor=UIColor.redColor()
        self.myTableView.tableHeaderView=tableHeader
        
        //表屐
        let tableFotter=UILabel(frame: CGRectMake(0,0,self.view.frame.size.width,60))
        tableFotter.text="我是表视图表尾"
        tableFotter.textAlignment=NSTextAlignment.Center
        tableFotter.backgroundColor=UIColor.blueColor()
        self.myTableView.tableFooterView=tableFotter
        
        //网络数数据
       
        self.requestData()

    }
    //网络数数据
    func requestData(){
        let path=NSBundle.mainBundle().pathForResource("weibo", ofType: "json")
        let data=NSData(contentsOfFile: path!)
        let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
        
       
        let arrayb =  jsonData?.objectForKey("statuese") as! NSArray
       
        dataSource.addObjectsFromArray(arrayb as [AnyObject])

    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let element = dataSource[indexPath.row] as! NSDictionary
        //昵称
        let userNic = element["user"] as! NSDictionary
        
        let nickname = userNic["name"] as! String

        //时间
        let create_at = WBHelper.timeLineWidthStringData( element["created_at"] as? String)
        let sourceText = NSMutableAttributedString()
        if let _ = create_at {
            let dic = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.orangeColor()]
            
            let timeText = NSMutableAttributedString(string: create_at!, attributes: dic)
            sourceText.appendAttributedString(timeText)
        }
        //处理html
        let source = WBHelper.soureceText(element["source"] as! String)
        let text = element["text"] as! String
        let avatal_url=userNic["avatar_hd"] as! String
        let header_url=NSURL(string: avatal_url)
        
        //来自
        let dic = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.lightGrayColor()]
        
        let fromText = NSMutableAttributedString(string: " 来自", attributes: dic)
        sourceText.appendAttributedString(fromText)

        

            let a = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.blueColor()]

            let atimeText = NSMutableAttributedString(string: source, attributes: a)
            sourceText.appendAttributedString(atimeText)
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! WeiboTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.selectionStyle=UITableViewCellSelectionStyle.None
        cell.nickeNameLabel.text=nickname
        cell.sourceLabel.attributedText=sourceText
        cell.publishTextlabel.text=text
        cell.HeadImageView.sd_setImageWithURL(header_url)
        return cell
    }
    
    
    func touchSourceLable(cell: WeiboTableViewCell, sourceLabel: UILabel, location: CGPoint,indexPath:NSIndexPath) {
        print("location:\(location)")
        
         print("点击了:\(cell.indexPath?.row)")
        
         let element = dataSource[indexPath.row] as! NSDictionary
         let source = WBHelper.soureceText(element["source"] as! String)
        
        let a = [NSFontAttributeName:UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.blueColor()]
        
        let atimeText = NSMutableAttributedString(string: source, attributes: a)
        
        let sourceSize = WBHelper.calculateAttributeTextSize(atimeText)
        let totalSize = WBHelper.calculateAttributeTextSize(NSMutableAttributedString(attributedString: sourceLabel.attributedText!))
        
        if totalSize.width - sourceSize.width <= location.x {
            
            let href = WBHelper.soureceHref(element["source"] as! String)
            print(href)
        }

    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

