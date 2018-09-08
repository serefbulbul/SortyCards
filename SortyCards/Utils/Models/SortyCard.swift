//
//  SortyCard.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

struct SortyCard: CustomStringConvertible, Equatable {

    var rank: CardRank
    var type: CardType

    var description: String {
        return "The \(rank.description) of \(type.description)"
    }

    var image: UIImage? {
        return UIImage(named: "\(rank.description)_of_\(type.description)")
    }
    
    var viewTag: Int {
        return type.priority * 1000 + rank.rawValue
    }

    static func createFullDeck() -> [SortyCard] {
        let ranks = CardRank.allValues()
        let types = CardType.allValues()

        var deck = [SortyCard]()

        for type in types {
            for rank in ranks {
                deck.append(SortyCard(rank: rank, type: type))
            }
        }

        return deck
    }

    static func == (lhs: SortyCard, rhs: SortyCard) -> Bool {
        return (lhs.rank == rhs.rank && lhs.type == rhs.type)
    }

}
