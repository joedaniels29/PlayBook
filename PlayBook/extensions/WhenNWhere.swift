//
//  WhenNWhere.swift
//  REACH
//
//  Created by Joseph Daniels on 4/5/15.
//  Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import Foundation

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}