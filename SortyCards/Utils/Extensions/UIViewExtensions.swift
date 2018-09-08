//
//  UIViewExtensions.swift
//  SortyCards
//
//  Created by Seref Bulbul on 7.09.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

extension UIView {

    func drawShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 3

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}
