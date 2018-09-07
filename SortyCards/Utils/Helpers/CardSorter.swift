//
//  CardSorter.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import Foundation

class CardSorter {

    static func sort123(deck: [SortyCard]) -> [[SortyCard]] {
        var sortedCardList = [[SortyCard]]()

        let sortedDeck = deck.sorted { (sortyCard1, sortyCard2) -> Bool in
            if sortyCard1.type == sortyCard2.type {
                return sortyCard1.rank.rawValue < sortyCard2.rank.rawValue
            } else {
                return sortyCard1.type.priority < sortyCard2.type.priority
            }
        }
        var searchDeck = sortedDeck

        for card in sortedDeck {
            let sortedCards = checkCardSequenceForSort123(card: card, deck: searchDeck)

            if sortedCards.count > 2 {
                sortedCardList.append(sortedCards)
                searchDeck = searchDeck.filter({ (sortyCard) -> Bool in
                    return !sortedCards.contains(sortyCard)
                })
            }
        }

        sortedCardList.append(searchDeck)

        return sortedCardList
    }

    private static func checkCardSequenceForSort123(card: SortyCard, deck: [SortyCard]) -> [SortyCard] {
        let nextCardIndex = deck.index { (deckCard) -> Bool in
            return (card.type == deckCard.type && deckCard.rank.rawValue == card.rank.rawValue + 1)
        }

        if let nextCardIndex = nextCardIndex {
            var returnArray = checkCardSequenceForSort123(card: deck[nextCardIndex], deck: deck)
            returnArray.insert(card, at: 0)

            return returnArray
        } else {
            return [card]
        }
    }

    static func sort777(deck: [SortyCard]) -> [[SortyCard]] {
        var sortedCardList = [[SortyCard]]()

        var searchDeck = deck

        for card in deck {
            let sortedCards = checkCardSequenceForSort777(card: card, deck: searchDeck)

            if sortedCards.count > 2 {
                sortedCardList.append(sortedCards)
                searchDeck = searchDeck.filter({ (sortyCard) -> Bool in
                    return !sortedCards.contains(sortyCard)
                })
            }
        }

        sortedCardList.append(searchDeck)

        return sortedCardList
    }

    private static func checkCardSequenceForSort777(card: SortyCard, deck: [SortyCard]) -> [SortyCard] {
        let nextCardIndex = deck.index { (deckCard) -> Bool in
            return (card.type != deckCard.type && deckCard.rank.rawValue == card.rank.rawValue)
        }

        if let nextCardIndex = nextCardIndex {
            var reducedDeck = deck
            
            if let cardIndex = reducedDeck.index(where: { (sortyCard) -> Bool in
                return sortyCard == card
            }) {
                reducedDeck.remove(at: cardIndex)
            }

            var returnArray = checkCardSequenceForSort777(card: deck[nextCardIndex], deck: reducedDeck)
            returnArray.insert(card, at: 0)

            return returnArray
        } else {
            return [card]
        }
    }

    static func sortSmart(deck: [SortyCard]) -> [[SortyCard]] {
        return [[SortyCard]]()
    }

}

