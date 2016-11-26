//
// Created by Joseph Daniels on 11/13/15.
// Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import Foundation
import Cartography
//#if target(OSX)
//#if target(OSX)


func fillParent(view:UIView){
    constrain(view){ v1 in
        v1.top == v1.superview!.top
        v1.right == v1.superview!.right
        v1.left == v1.superview!.left
        v1.bottom == v1.superview!.bottom
    }
}
