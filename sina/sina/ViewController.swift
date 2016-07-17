//
//  ViewController.swift
//  sina
//
//  Created by 淘未 on 16/7/12.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        let create_at=element["created_at"] as! String
        //处理html
        let source = element["source"] as! String
        let text = element["text"] as! String
        let avatal_url=userNic["avatar_hd"] as! String
        let header_url=NSURL(string: avatal_url)
   
print(avatal_url)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! WeiboTableViewCell

        cell.selectionStyle=UITableViewCellSelectionStyle.None
        cell.nickeNameLabel.text=nickname
        cell.sourceLabel.text=create_at+"来自"+source
        cell.publishTextlabel.text=text
        cell.HeadImageView.sd_setImageWithURL(header_url)
        return cell
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

