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
        let possibleCardGroups = getPossibleCardGroupsForSortSmart(deck: deck)

        let cardGroupsAndScores = getPossibleCardGroupsWithScoresForSortSmart(possibleCardGroups: possibleCardGroups)
        
        let cardGroupCombinationsWithTotalScores = getCardGroupCombinationsWithTotalScoresForSortSmart(cardGroupsAndScores: cardGroupsAndScores)

        if let selectedDeck = cardGroupCombinationsWithTotalScores.first?.0 {
            var sortedCardList = selectedDeck
            var searchDeck = deck

            for cardGroup in selectedDeck {
                for card in cardGroup {
                    if let index = searchDeck.index(of: card) {
                        searchDeck.remove(at: index)
                    }
                }
            }
            
            sortedCardList.append(searchDeck)

            return checkAndReturn(sortedCardList: sortedCardList)
        }

        return nil
    }
    
    private static func getPossibleCardGroupsForSortSmart(deck: [SortyCard]) -> [[SortyCard]] {
        var possibleCardGroups = [[SortyCard]]()
        
        let sort123CardGroups = sort123(deck: deck)
        let sort777CardGroups = sort777(deck: deck)
        
        if let sort123CardGroups = sort123CardGroups {
            for i in 0..<sort123CardGroups.count - 1 {
                possibleCardGroups.append(sort123CardGroups[i])
                
                for j in 3..<sort123CardGroups[i].count {
                    for k in 0...sort123CardGroups[i].count - j {
                        possibleCardGroups.append(Array(sort123CardGroups[i][k..<k + j]))
                    }
                }
            }
        }
        
        if let sort777CardGroups = sort777CardGroups {
            for i in 0..<sort777CardGroups.count - 1 {
                possibleCardGroups.append(sort777CardGroups[i])
                
                if sort777CardGroups[i].count == 4 {
                    let indexes = [0, 1, 2, 3]
                    
                    for j in indexes {
                        var cardGroup = sort777CardGroups[i]
                        cardGroup.remove(at: j)
                        
                        possibleCardGroups.append(cardGroup)
                    }
                }
            }
        }
        
        return possibleCardGroups
    }
    
    private static func getPossibleCardGroupsWithScoresForSortSmart(possibleCardGroups: [[SortyCard]]) -> [([SortyCard], Int)] {
        let cardGroupScores = possibleCardGroups.map { (cardGroup: [SortyCard]) -> (Int) in
            var score = 0
            
            for card in cardGroup {
                score += card.rank.rawValue
            }
            
            return score
        }
        
        return zip(possibleCardGroups, cardGroupScores).sorted { (cardGroupAndScore1, cardGroupAndScore2) -> Bool in
            return cardGroupAndScore1.1 > cardGroupAndScore2.1
        }
    }
    
    private static func getCardGroupCombinationsWithTotalScoresForSortSmart(cardGroupsAndScores: [([SortyCard], Int)]) -> [([[SortyCard]], Int)] {
        var cardGroupCombinationsWithTotalScores = [([[SortyCard]](), 0)]
        
        for i in 0..<cardGroupsAndScores.count {
            var cardGroupCombination = [[SortyCard]]()
            var cardGroupCombinationTotalScore = 0
            
            cardGroupCombination.append(cardGroupsAndScores[i].0)
            cardGroupCombinationTotalScore += cardGroupsAndScores[i].1
            
            for j in 0..<cardGroupsAndScores.count {
                var isConflict = false
                let currentCardGroup = cardGroupsAndScores[j].0
                
                for cardGroup in cardGroupCombination {
                    if cardGroup.contains(where: { (sortyCard) -> Bool in
                        return currentCardGroup.contains(sortyCard)
                    }) {
                        isConflict = true
                        break
                    }
                }
                
                if !isConflict {
                    cardGroupCombination.append(currentCardGroup)
                    cardGroupCombinationTotalScore += cardGroupsAndScores[i].1
                }
            }
            
            cardGroupCombinationsWithTotalScores.append((cardGroupCombination, cardGroupCombinationTotalScore))
        }
        
        return cardGroupCombinationsWithTotalScores.sorted { (cardGroupCombination1, cardGroupCombination2) -> Bool in
            return cardGroupCombination1.1 > cardGroupCombination2.1
        }
    }

    private static func checkAndReturn(sortedCardList: [[SortyCard]]) -> [[SortyCard]]? {
        if sortedCardList.count < 2 {
            return nil
        } else {
            return sortedCardList
        }
    }

}

