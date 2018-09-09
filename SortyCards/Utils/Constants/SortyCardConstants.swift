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
    static let cardWidth = UIScreen.main.bounds.width * 14.0 / 100.0
    static let cardHeight = cardWidth / 2 * 3
    static let horizontalIntervalBetweenCards = cardWidth / 2.0
    static let verticalIntervalBetweenCards = cardHeight / 30.0
    static let distributionAnimationDuration = 0.2
    static let sortAnimationDuration = 1.0
    static let sortAnimationDurationForPanGesture = 0.4
    static let rotationCoefficient = Double.pi / 90
    static let scaleCoefficient = CGFloat(6 / 5)
    
}
