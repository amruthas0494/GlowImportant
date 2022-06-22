//
//  Date+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 23/11/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
    }
    
    func timeAgoSinceDate() -> String {
        
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(self)
        let latest = (earliest == now as Date) ? self as NSDate : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        if (components.year! >= 2) {
            return "\(components.year ?? 1) Years ago"
        } else if (components.year! >= 1) {
            return "1 Year ago"
        } else if (components.month! >= 2) {
            return "\(components.month ?? 2) Months ago"
        } else if (components.month! >= 1) {
            return "1 Month ago"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear ?? 1) Weeks ago"
        } else if (components.weekOfYear! >= 1) {
            return "1 Week ago"
        } else if (components.day! >= 2) {
            return "\(components.day ?? 2) Days ago"
        } else if (components.day! >= 1) {
            return "1 Day ago"
        } else if (components.hour! >= 2) {
            return "\(components.hour ?? 0) Hours ago"
        } else if (components.hour! >= 1) {
            return "\(components.hour ?? 0) Hour ago"
        } else if (components.minute! >= 2) {
            return "\(components.minute ?? 0) Minutes ago"
        } else if (components.minute! >= 1) {
            return "1  minute ago"
        } else {
            return "Now"
        }
    }
}
