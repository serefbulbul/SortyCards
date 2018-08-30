//
//  CardType.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import Foundation

enum CardType: CustomStringConvertible {

    case spades, hearts, diamonds, clubs

    var description: String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }

    var priority: Int {
        switch self {
        case .spades:
            return 1
        case .hearts:
            return 2
        case .diamonds:
            return 3
        case .clubs:
            return 4
        }
    }

    static func allValues() -> [CardType] {
        return [.spades, .hearts, .diamonds, .clubs]
    }

}
