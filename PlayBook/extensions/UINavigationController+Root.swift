//
// Created by Joseph Daniels on 1/19/15.
// Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import UIKit
extension UINavigationController{
    var rootViewController:UIViewController! {
        get{
            return self.viewControllers[0] 
        }
    }
}
