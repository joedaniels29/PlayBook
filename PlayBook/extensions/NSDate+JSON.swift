//
//  NSDate+JSON.swift
//  REACH
//
//  Created by Joseph Daniels on 1/17/15.
//  Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import Foundation

extension NSDateFormatter{
    class func jsonFormatter() -> NSDateFormatter{
        let dateFormatter = NSDateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY-MM-dd'T'HH:mm:ssZZZ")
        return dateFormatter
    }
}
extension NSDate{
    func toJson() -> NSString{
        return NSDateFormatter.jsonFormatter().stringFromDate(self);
    }
}