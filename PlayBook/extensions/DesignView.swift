//
//  DesignView.swift
//  REACH
//
//  Created by Joseph Daniels on 3/28/15.
//  Copyright (c) 2015 Johns Hopkins Technology Inovation Center. All rights reserved.
//

import Foundation
import UIKit

class DesignView : UIView {
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        if let sublayers = layer.sublayers{
            for l in sublayers	{
                if let l = l as? CAGradientLayer {
                    l.frame = layer.bounds
                }
            }
        }
    }
}