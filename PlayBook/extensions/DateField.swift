//
//  DateField.swift
//  REACH
//
//  Created by Joseph Daniels on 3/28/15.
//  Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import Foundation
import UIKit
class DateField: UITextField {

    var date: NSDate = NSDate(){
        didSet{
            self.updateDateString()
        }
    }
    
    class func defaultFormatter() -> NSDateFormatter {
        let f = NSDateFormatter()
        f.dateFormat = "M/d/yy"
        return f
    }
    
    var dateFormatter = DateField.defaultFormatter()
    
    func updateDateString(){
        self.text  = self.dateFormatter.stringFromDate(self.date)
    }
}

class DateLabel: UILabel {
    
    var date: NSDate = NSDate(){
        didSet{
            self.updateDateString()
        }
    }
    
    class func defaultFormatter() -> NSDateFormatter {
        let f = NSDateFormatter()
        f.dateFormat = "M/d/yy"
        return f
    }
    
    var dateFormatter = DateField.defaultFormatter()
    
    func updateDateString(){
        self.text  = self.dateFormatter.stringFromDate(self.date)
    }
}