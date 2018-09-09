//
//  SortyCardConstants.swift
//  SortyCards
//
//  Created by Seref Bulbul on 9.09.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

enum SortyCardConstants {

    static let cardNumber = 11
    static let cardWidth = UIScreen.main.bounds.width / CGFloat(9)
    static let cardHeight = cardWidth * 1.6
    static let distributionAnimationDuration = 0.2
    static let sortAnimationDuration = 1.0
    static let panGestureAnimationDuration = 0.4
    static let rotationCoefficient = Double.pi / 90
    static let scaleCoefficient = CGFloat(1.2)
    static let startAngle = CGFloat(1.4)
    static let endAngle = CGFloat(1.6)
    static let arcRadiusCoefficient = CGFloat(0.4)
    static let arcCenterXCoefficient = CGFloat(0.5)
    static var arcCenter = CGPoint(x: UIScreen.main.bounds.width * SortyCardConstants.arcCenterXCoefficient, y: arcRadius + (UIScreen.main.bounds.height * SortyCardConstants.arcRadiusCoefficient))
    static let arcWidth = UIScreen.main.bounds.width * 0.8
    static let arcRadius = arcWidth / (2 * sin(.pi / 10))

}
