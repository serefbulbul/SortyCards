//
//  TestDecks.swift
//  SortyCardsTests
//
//  Created by Seref Bulbul on 9.09.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

@testable import SortyCards

import Foundation

class TestDecks {
    
    static let sampleDeck = [SortyCard(rank: .ace, type: .hearts),
                             SortyCard(rank: .two, type: .spades),
                             SortyCard(rank: .five, type: .diamonds),
                             SortyCard(rank: .four, type: .hearts),
                             SortyCard(rank: .ace, type: .spades),
                             SortyCard(rank: .three, type: .diamonds),
                             SortyCard(rank: .four, type: .clubs),
                             SortyCard(rank: .four, type: .spades),
                             SortyCard(rank: .ace, type: .diamonds),
                             SortyCard(rank: .three, type: .spades),
                             SortyCard(rank: .four, type: .diamonds)]
    
    static let deck1 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .two, type: .hearts),
                        SortyCard(rank: .five, type: .hearts),
                        SortyCard(rank: .four, type: .hearts),
                        SortyCard(rank: .six, type: .hearts),
                        SortyCard(rank: .king, type: .hearts),
                        SortyCard(rank: .queen, type: .hearts),
                        SortyCard(rank: .eight, type: .hearts),
                        SortyCard(rank: .jack, type: .hearts),
                        SortyCard(rank: .three, type: .hearts),
                        SortyCard(rank: .seven, type: .hearts)]
    
    static let deck2 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .two, type: .hearts),
                        SortyCard(rank: .five, type: .hearts),
                        SortyCard(rank: .four, type: .hearts),
                        SortyCard(rank: .six, type: .hearts),
                        SortyCard(rank: .jack, type: .hearts),
                        SortyCard(rank: .ten, type: .hearts),
                        SortyCard(rank: .eight, type: .hearts),
                        SortyCard(rank: .nine, type: .hearts),
                        SortyCard(rank: .three, type: .hearts),
                        SortyCard(rank: .seven, type: .hearts)]
    
    static let deck3 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .two, type: .hearts),
                        SortyCard(rank: .five, type: .clubs),
                        SortyCard(rank: .four, type: .hearts),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .three, type: .diamonds),
                        SortyCard(rank: .four, type: .clubs),
                        SortyCard(rank: .four, type: .spades),
                        SortyCard(rank: .ace, type: .diamonds),
                        SortyCard(rank: .three, type: .spades),
                        SortyCard(rank: .four, type: .diamonds)]
    
    static let deck4 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .ace, type: .diamonds),
                        SortyCard(rank: .ace, type: .clubs),
                        SortyCard(rank: .jack, type: .spades),
                        SortyCard(rank: .jack, type: .diamonds),
                        SortyCard(rank: .jack, type: .clubs),
                        SortyCard(rank: .jack, type: .hearts),
                        SortyCard(rank: .two, type: .diamonds),
                        SortyCard(rank: .three, type: .diamonds),
                        SortyCard(rank: .four, type: .diamonds)]
    
    static let deck5 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .ace, type: .diamonds),
                        SortyCard(rank: .ace, type: .clubs),
                        SortyCard(rank: .jack, type: .spades),
                        SortyCard(rank: .jack, type: .diamonds),
                        SortyCard(rank: .jack, type: .clubs),
                        SortyCard(rank: .jack, type: .hearts),
                        SortyCard(rank: .king, type: .diamonds),
                        SortyCard(rank: .king, type: .spades),
                        SortyCard(rank: .king, type: .clubs)]
    
    static let deck6 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .ace, type: .diamonds),
                        SortyCard(rank: .ace, type: .clubs),
                        SortyCard(rank: .two, type: .spades),
                        SortyCard(rank: .two, type: .diamonds),
                        SortyCard(rank: .two, type: .clubs),
                        SortyCard(rank: .two, type: .hearts),
                        SortyCard(rank: .three, type: .diamonds),
                        SortyCard(rank: .three, type: .spades),
                        SortyCard(rank: .three, type: .clubs),
                        SortyCard(rank: .four, type: .hearts),
                        SortyCard(rank: .four, type: .diamonds),
                        SortyCard(rank: .four, type: .spades),
                        SortyCard(rank: .four, type: .clubs)]
    
    static let deck7 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .ace, type: .clubs),
                        SortyCard(rank: .two, type: .diamonds),
                        SortyCard(rank: .two, type: .spades),
                        SortyCard(rank: .three, type: .spades),
                        SortyCard(rank: .three, type: .clubs)]
    
    static let deck8 = [SortyCard(rank: .ace, type: .hearts),
                        SortyCard(rank: .two, type: .spades),
                        SortyCard(rank: .five, type: .spades),
                        SortyCard(rank: .four, type: .hearts),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .three, type: .diamonds),
                        SortyCard(rank: .four, type: .clubs),
                        SortyCard(rank: .four, type: .spades),
                        SortyCard(rank: .ace, type: .diamonds),
                        SortyCard(rank: .three, type: .spades),
                        SortyCard(rank: .four, type: .diamonds)]
    
    static let deck9 = [SortyCard(rank: .ace, type: .clubs),
                        SortyCard(rank: .two, type: .clubs),
                        SortyCard(rank: .five, type: .spades),
                        SortyCard(rank: .four, type: .clubs),
                        SortyCard(rank: .ace, type: .spades),
                        SortyCard(rank: .three, type: .diamonds),
                        SortyCard(rank: .queen, type: .clubs),
                        SortyCard(rank: .four, type: .hearts),
                        SortyCard(rank: .jack, type: .diamonds),
                        SortyCard(rank: .three, type: .spades),
                        SortyCard(rank: .king, type: .diamonds)]
    
    static let deck10 = [SortyCard(rank: .two, type: .hearts),
                         SortyCard(rank: .two, type: .spades),
                         SortyCard(rank: .five, type: .diamonds),
                         SortyCard(rank: .four, type: .hearts),
                         SortyCard(rank: .ace, type: .spades),
                         SortyCard(rank: .three, type: .diamonds),
                         SortyCard(rank: .four, type: .clubs),
                         SortyCard(rank: .four, type: .spades),
                         SortyCard(rank: .two, type: .diamonds),
                         SortyCard(rank: .three, type: .spades),
                         SortyCard(rank: .four, type: .diamonds)]
    
    static let deck11 = [SortyCard(rank: .two, type: .clubs),
                         SortyCard(rank: .five, type: .spades),
                         SortyCard(rank: .five, type: .diamonds),
                         SortyCard(rank: .four, type: .hearts),
                         SortyCard(rank: .five, type: .hearts),
                         SortyCard(rank: .three, type: .diamonds),
                         SortyCard(rank: .four, type: .clubs),
                         SortyCard(rank: .four, type: .spades),
                         SortyCard(rank: .two, type: .diamonds),
                         SortyCard(rank: .three, type: .spades),
                         SortyCard(rank: .four, type: .diamonds)]
}
