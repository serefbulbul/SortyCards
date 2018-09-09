//
//  CardSorter.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import Foundation

enum SortingType {

    case sort123
    case sort777
    case sortSmart

}

class CardSorter {

    static func sort(sortingType: SortingType, deck: [SortyCard]) -> [[SortyCard]]? {
        switch sortingType {
        case .sort123:
            return sort123(deck: deck)
        case .sort777:
            return sort777(deck: deck)
        case .sortSmart:
            return sortSmart(deck: deck)
        }
    }

    private static func sort123(deck: [SortyCard]) -> [[SortyCard]]? {
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

        return checkAndReturn(sortedCardList: sortedCardList)
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

    private static func sort777(deck: [SortyCard]) -> [[SortyCard]]? {
        var sortedCardList = [[SortyCard]]()
        var searchDeck = deck

        for card in deck {
            let sortedCards = checkSameTypeCardsForSort777(card: card, deck: searchDeck)

            if sortedCards.count > 2 {
                sortedCardList.append(sortedCards)
                searchDeck = searchDeck.filter({ (sortyCard) -> Bool in
                    return !sortedCards.contains(sortyCard)
                })
            }
        }

        sortedCardList.append(searchDeck)

        return checkAndReturn(sortedCardList: sortedCardList)
    }

    private static func checkSameTypeCardsForSort777(card: SortyCard, deck: [SortyCard]) -> [SortyCard] {
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

            var returnArray = checkSameTypeCardsForSort777(card: deck[nextCardIndex], deck: reducedDeck)
            returnArray.insert(card, at: 0)

            return returnArray
        } else {
            return [card]
        }
    }

    private static func sortSmart(deck: [SortyCard]) -> [[SortyCard]]? {
        var sortedCardList = [[SortyCard]]()
        var searchDeck = deck
        
        let sort123CardGroups = sort123(deck: deck)

        if let sort123CardGroups = sort123CardGroups {
            for cardGroup in sort123CardGroups {
                if cardGroup.count > 3 {
                    let difference = cardGroup.count - 3
                    
                    for index in ((cardGroup.count - 1 - difference)..<(cardGroup.count - 1)).reversed() {
                        let sort777CardGroups = sort777(deck: searchDeck)
                    }
                } else {
                    sortedCardList.append(cardGroup)
                    searchDeck = searchDeck.filter({ (sortyCard) -> Bool in
                        return !cardGroup.contains(sortyCard)
                    })
                }
            }
        } else {
            return nil
        }

        for card in deck {
            let sortedCards = checkSameTypeCardsForSort777(card: card, deck: searchDeck)

            if sortedCards.count > 2 {
                sortedCardList.append(sortedCards)
                searchDeck = searchDeck.filter({ (sortyCard) -> Bool in
                    return !sortedCards.contains(sortyCard)
                })
            }
        }

        sortedCardList.append(searchDeck)

        return checkAndReturn(sortedCardList: sortedCardList)
    }

    private static func checkAndReturn(sortedCardList: [[SortyCard]]) -> [[SortyCard]]? {
        if sortedCardList.count < 2 {
            return nil
        } else {
            return sortedCardList
        }
    }

}

