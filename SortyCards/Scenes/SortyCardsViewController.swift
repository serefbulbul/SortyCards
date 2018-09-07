//
//  SortyCardsViewController.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

private enum Constants {
    
    static let cardNumber = 11
    
}

class SortyCardsViewController: UIViewController {

//    private let deck = Array(SortyCard.createFullDeck().shuffled().prefix(Constants.cardNumber))
    private let deck = [SortyCard(rank: .ace, type: .hearts),
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let sorted123Deck = CardSorter.sort123(deck: deck)
//        let sorted777Deck = CardSorter.sort777(deck: deck)
        let sortedSmartDeck = CardSorter.sortSmart(deck: deck)
        
        print()
    }

}

