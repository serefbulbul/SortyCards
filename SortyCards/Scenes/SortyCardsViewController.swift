//
//  SortyCardsViewController.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

private enum CardConstants {

    static let cardNumber = 11
    static let cardWidth = CGFloat(100)
    static let cardHeight = CGFloat(150)
    static let horizontalIntervalBetweenCards = CGFloat(40)
    static let verticalIntervalBetweenCards = CGFloat(5)
    static let animationDuration = 1.0
    static let rotationCoefficient = Double.pi / 90

}

class SortyCardsViewController: UIViewController {

//    private let originalDeck = Array(SortyCard.createFullDeck().shuffled().prefix(CardConstants.cardNumber))
    private let originalDeck = [SortyCard(rank: .ace, type: .hearts),
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
    private var deck = [SortyCard]()

    private var isStarted = false
    private var cardPosition = CGRect.zero
    private var cardBeginningPosition = CGRect.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        deck = originalDeck

        cardPosition = CGRect(x: (view.frame.size.width - (CardConstants.horizontalIntervalBetweenCards * CGFloat(deck.count))) / 2, y: view.frame.size.height - (CardConstants.cardHeight * 1.5) - (CardConstants.verticalIntervalBetweenCards * CGFloat(deck.count / 2)), width: CardConstants.cardWidth, height: CardConstants.cardHeight)
        cardBeginningPosition = CGRect(x: (view.frame.size.width - CardConstants.cardWidth) / 2, y: view.frame.size.height, width: CardConstants.cardWidth, height: CardConstants.cardHeight)

        drawSortyCards()
    }

    private func drawSortyCards() {
        var currentCardStartingX = cardPosition.origin.x
        var currentCardStartingY = cardPosition.origin.y

        for index in 0..<deck.count {
            let cardToPosition = CGRect(x: currentCardStartingX, y: currentCardStartingY, width: CardConstants.cardWidth, height: CardConstants.cardHeight)

            let sortyCardView = SortyCardView(frame: cardBeginningPosition, sortyCard: deck[index])

            currentCardStartingX += CardConstants.horizontalIntervalBetweenCards

            if index < (deck.count / 2) {
                currentCardStartingY -= CardConstants.verticalIntervalBetweenCards
                sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: CGFloat((-1.0 * Double((deck.count / 2) - index)) * CardConstants.rotationCoefficient))
            } else {
                currentCardStartingY += CardConstants.verticalIntervalBetweenCards
                sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: CGFloat((Double(index - (deck.count / 2))) * CardConstants.rotationCoefficient))
            }

            view.addSubview(sortyCardView)

            UIView.animate(withDuration: CardConstants.animationDuration) {
                sortyCardView.frame = cardToPosition
            }
        }
    }

    private func updateDeckWithNewCardGroups(cardGroups: [[SortyCard]]?) {
        if let cardGroups = cardGroups {
            var newDeck = [SortyCard]()

            for cardGroup in cardGroups {
                for card in cardGroup {
                    newDeck.append(card)
                }
            }

            deck = newDeck

            updateCardPositions()
        }
    }

    private func updateCardPositions() {
        var currentCardStartingX = cardPosition.origin.x
        var currentCardStartingY = cardPosition.origin.y

        for index in 0..<deck.count {
            let cardToPosition = CGRect(x: currentCardStartingX, y: currentCardStartingY, width: CardConstants.cardWidth, height: CardConstants.cardHeight)

            if let sortyCardView = view.viewWithTag(deck[index].viewTag) as? SortyCardView {
                currentCardStartingX += CardConstants.horizontalIntervalBetweenCards

                if index < (deck.count / 2) {
                    currentCardStartingY -= CardConstants.verticalIntervalBetweenCards
                    sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: CGFloat((-1.0 * Double((deck.count / 2) - index)) * CardConstants.rotationCoefficient))
                } else {
                    currentCardStartingY += CardConstants.verticalIntervalBetweenCards
                    sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: CGFloat((Double(index - (deck.count / 2))) * CardConstants.rotationCoefficient))
                }

                sortyCardView.removeFromSuperview()
                view.addSubview(sortyCardView)

                UIView.animate(withDuration: CardConstants.animationDuration) {
                    sortyCardView.frame = cardToPosition
                }
            }
        }
    }

    @IBAction func sort123Tapped(_ sender: Any) {
        updateDeckWithNewCardGroups(cardGroups: CardSorter.sort(sortingType: .sort123, deck: originalDeck))
    }

    @IBAction func sort777Tapped(_ sender: Any) {
        updateDeckWithNewCardGroups(cardGroups: CardSorter.sort(sortingType: .sort777, deck: originalDeck))
    }

    @IBAction func sortSmartTapped(_ sender: Any) {
        updateDeckWithNewCardGroups(cardGroups: CardSorter.sort(sortingType: .sortSmart, deck: originalDeck))
    }

}

