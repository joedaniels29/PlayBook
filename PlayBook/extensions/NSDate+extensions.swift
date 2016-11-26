//
// Created by Joseph Daniels on 12/26/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
extension NSDateFormatter{
    static var durationFormatter: NSDateFormatter{
        let it = NSDateFormatter()
        it.dateFormat = "HH:mm:ss"
        it.timeZone = NSTimeZone(name:"UTC")
        return it
    }
}