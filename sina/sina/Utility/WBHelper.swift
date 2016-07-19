//
//  WBHelper.swift
//  sina
//
//  Created by 黄 家金 on 16/7/16.
//  Copyright © 2016年 淘未. All rights reserved.
//

import UIKit
var textRegex:NSRegularExpression?
var hrefRegex:NSRegularExpression?
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
    
    class func sourceTextRegex() -> NSRegularExpression? {
        if textRegex == nil {
            do{
                let regex = "(?<=>).+(?=<)"
                try textRegex = NSRegularExpression(pattern: regex, options: .AllowCommentsAndWhitespace)
            }catch{
                
            }
            
           
        }
         return textRegex
    }
    
    
    class func sourceHrefRegex() -> NSRegularExpression? {
        if hrefRegex == nil {
            do{
                let regex = "(?<=href=\").+(?=\"\\s)"
                try hrefRegex = NSRegularExpression(pattern: regex, options: .AllowCommentsAndWhitespace)
            }catch{
                
            }
            
            
        }
        return hrefRegex
    }
    
    class func soureceText(htmlString:String) -> String {
        var text:String?
        WBHelper.sourceTextRegex()
        let opt = NSMatchingOptions.init(rawValue: 0)
        let range = NSMakeRange(0, htmlString.startIndex.distanceTo(htmlString.endIndex))
        let result = textRegex?.firstMatchInString(htmlString, options: opt, range: range)
        
        if result != nil && result?.range.location != NSNotFound {
            let textRange = Range(start: htmlString.startIndex.advancedBy((result?.range.location)!), end: htmlString.startIndex.advancedBy((result?.range.location)! + (result?.range.length)!))
            
            text = htmlString.substringWithRange(textRange)
        }
        return text!
    }
    
    
    class func soureceHref(htmlString:String) -> String {
        var text:String?
        WBHelper.sourceHrefRegex()
        let opt = NSMatchingOptions.init(rawValue: 0)
        let range = NSMakeRange(0, htmlString.startIndex.distanceTo(htmlString.endIndex))
        let result = hrefRegex?.firstMatchInString(htmlString, options: opt, range: range)
        
        if result != nil && result?.range.location != NSNotFound {
            let textRange = Range(start: htmlString.startIndex.advancedBy((result?.range.location)!), end: htmlString.startIndex.advancedBy((result?.range.location)! + (result?.range.length)!))
            
            text = htmlString.substringWithRange(textRange)
        }
        return text!
    }
    
    
    class func calculateAttributeTextSize(attributeStr:NSMutableAttributedString) -> CGSize {
        let frameSetterRef = CTFramesetterCreateWithAttributedString(attributeStr)
        let cfRange  = CFRangeMake(0, 0)
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, CGFloat.max)
        let size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, cfRange, nil, maxSize, nil)
        return size
    }
    
    
    
    
}
