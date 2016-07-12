//
//  ViewController.swift
//  sina
//
//  Created by 淘未 on 16/7/12.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var  myTableView:UITableView!

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
        
        //表示图分区
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! WeiboTableViewCell
        
//        if cell.textLabel?.text == nil {
//            let tmpString="初始值"
//            cell.textLabel?.text=tmpString+"我是第"+String(indexPath.row)+"行"
//        } else {
//            let tmpString = cell.textLabel?.text
//            cell.textLabel?.text = tmpString!+"我是第"+String(indexPath.row)+"行"
//        }
//        
//       
//        cell.imageView?.image = UIImage(named: "logo 2")
//        
//        let tableFotter=UILabel(frame: CGRectMake(0,0,60,60))
//        tableFotter.text="我"
//        tableFotter.textAlignment=NSTextAlignment.Center
//        tableFotter.backgroundColor=UIColor.blueColor()
//
//
//        
//        cell.accessoryView = tableFotter
        cell.selectionStyle=UITableViewCellSelectionStyle.None
        
        return cell
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

