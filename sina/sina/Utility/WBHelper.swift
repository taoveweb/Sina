//
//  WBHelper.swift
//  sina
//
//  Created by 黄 家金 on 16/7/16.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit

class WBHelper: NSObject {
    
    class func timeLineWidthStringData(dataString:String?) -> String?{
        /*
         
         NSDate
         
         
         */
        
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat="EEE MMM d HH:mm:ss Z yyyy"
        dataFormatter.locale = NSLocale(localeIdentifier: "en_US")
        let date = dataFormatter.dateFromString(dataString!)
        
        let nowDate = NSDate()
        let spaceTimeinterval = nowDate.timeIntervalSince1970 - (date?.timeIntervalSince1970)!
        
        if spaceTimeinterval < 60 {
            return "刚刚"
        } else if spaceTimeinterval < 60 * 60 * 24{
            
            return "\(Int(spaceTimeinterval/60.0/60.0))小是之前"
            
        }else if spaceTimeinterval < 60 * 60 * 24 * 2 {
            let formatterYesterday = NSDateFormatter()
            formatterYesterday.dateFormat = "昨天 HH:mm"
            formatterYesterday.locale =  NSLocale.currentLocale()
            
            return formatterYesterday.stringFromDate(date!)
        }else if WBHelper.isSameYear(date){
            
            let formatterSameYear = NSDateFormatter()
            formatterSameYear.dateFormat = "M-d"
            formatterSameYear.locale =  NSLocale.currentLocale()
            
            
            return formatterSameYear.stringFromDate(date!)
        }else{
            
            let formatterSameYear = NSDateFormatter()
            formatterSameYear.dateFormat = "yyyy-M-dd"
            formatterSameYear.locale =  NSLocale.currentLocale()
            
            
            return formatterSameYear.stringFromDate(date!)
        }
        
    }
    
    
    class func isSameYear(date:NSDate?) -> Bool{
        let year = NSCalendar.currentCalendar().component(.Year, fromDate: date!)
        let now = NSCalendar.currentCalendar().component(.Year, fromDate: NSDate())
        return year == now
    }
}
