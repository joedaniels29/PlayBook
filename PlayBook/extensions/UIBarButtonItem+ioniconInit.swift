//
// Created by Joseph Daniels on 11/14/15.
// Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import Foundation
import ionicons

extension UIBarButtonItem {
//    public convenience init(title: String?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector)
    convenience init(ioniconTitle: String?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector, color:UIColor?=nil){
        let font = ionicons.IonIcons.fontWithSize(20)
        self.init(title: ioniconTitle, style: style, target: target, action: action)
//                barButton.transform = CGAffineTransformMakeRotation(CGFloat(0 - M_PI_2 - M_PI_4))
        var dict:[String:NSObject] = [NSFontAttributeName: font]
        if let color = color{
            dict[NSForegroundColorAttributeName] = color
        }
		self.setTitleTextAttributes(dict, forState: UIControlState.Normal)
        //			barButton.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Highlighted)
    }
    convenience init(ioniconLabel: String?, color:UIColor=UIColor.blackColor()){
        let font = ionicons.IonIcons.fontWithSize(20)
        let label = UILabel()
        label.font = font
        label.text = ioniconLabel
        label.textColor = color
        self.init(customView:label)
    }
}