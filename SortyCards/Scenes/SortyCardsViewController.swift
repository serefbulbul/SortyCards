//
//  SortyCardsViewController.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

class SortyCardsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var randomDeckButton: UIButton!

    // MARK: - Variables

    private let sampleDeck = [SortyCard(rank: .ace, type: .hearts),
                              SortyCard(rank: .ace, type: .spades),
                              SortyCard(rank: .ace, type: .clubs),
                              SortyCard(rank: .two, type: .diamonds),
                              SortyCard(rank: .two, type: .spades),
                              SortyCard(rank: .three, type: .spades),
                              SortyCard(rank: .three, type: .clubs)]

    private var originalDeck = [SortyCard]()
    private var deck = [SortyCard]()

    private var isStarted = false
    private var cardPosition = CGRect.zero
    private var cardBeginningPosition = CGRect.zero

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        originalDeck = sampleDeck

        initialization()
    }

    // MARK: - Business

    private func initialization() {
        deck = originalDeck

        cardPosition = CGRect(x: (view.frame.size.width - (SortyCardConstants.horizontalIntervalBetweenCards * CGFloat(deck.count + 1))) / 2, y: view.frame.size.height - (SortyCardConstants.cardHeight * 1.5) - (SortyCardConstants.verticalIntervalBetweenCards * CGFloat((deck.count / 2) + 1)), width: SortyCardConstants.cardWidth, height: SortyCardConstants.cardHeight)
        cardBeginningPosition = CGRect(x: (view.frame.size.width - SortyCardConstants.cardWidth) / 2, y: view.frame.size.height, width: SortyCardConstants.cardWidth, height: SortyCardConstants.cardHeight)

        updateCardPositions(forCardDistirution: true)
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

    private func updateCardPositions(forCardDistirution: Bool = false, forPanGesture: Bool = false) {
        var currentCardStartingX = cardPosition.origin.x
        var currentCardStartingY = cardPosition.origin.y

        for index in 0..<deck.count {
            let cardToPosition = CGRect(x: currentCardStartingX, y: currentCardStartingY, width: SortyCardConstants.cardWidth, height: SortyCardConstants.cardHeight)

            var sortyCardView = view.viewWithTag(deck[index].viewTag) as? SortyCardView

            if sortyCardView == nil {
                sortyCardView = SortyCardView(frame: cardBeginningPosition, sortyCard: deck[index])
            }

            if let sortyCardView = sortyCardView {
                currentCardStartingX += SortyCardConstants.horizontalIntervalBetweenCards

                if index < (deck.count / 2) {
                    currentCardStartingY -= SortyCardConstants.verticalIntervalBetweenCards
                } else if(index != (deck.count / 2) - 1) {
                    currentCardStartingY += SortyCardConstants.verticalIntervalBetweenCards
                }

                if index < (deck.count / 2) {
                    sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: CGFloat((-1.0 * Double((deck.count / 2) - index)) * SortyCardConstants.rotationCoefficient))
                } else if index == (deck.count / 2) {
                    sortyCardView.contentView.transform = CGAffineTransform.identity
                } else {
                    sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: CGFloat((Double(index - (deck.count / 2))) * SortyCardConstants.rotationCoefficient))
                }

                if forCardDistirution {
                    sortyCardView.isUserInteractionEnabled = true
                    sortyCardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
                }

                if !forCardDistirution {
                    sortyCardView.removeFromSuperview()
                }

                view.addSubview(sortyCardView)

                var animationDuration = 0.0

                if forCardDistirution {
                    animationDuration = SortyCardConstants.distributionAnimationDuration
                } else if forPanGesture {
                    animationDuration = SortyCardConstants.sortAnimationDurationForPanGesture
                } else {
                    animationDuration = SortyCardConstants.sortAnimationDuration
                }

                if forCardDistirution {
                    randomDeckButton.isEnabled = false
                }

                UIView.animate(withDuration: animationDuration, delay: forCardDistirution ? Double(index) * SortyCardConstants.distributionAnimationDuration : 0, options: [], animations: {
                    sortyCardView.frame = cardToPosition
                }) { _ in
                    if forCardDistirution, index == self.deck.count - 1 {
                        self.randomDeckButton.isEnabled = true
                    }
                }
            }
        }
    }

    @objc private func draggedView(_ sender: UIPanGestureRecognizer) {
        if let selectedSortyCardView = sender.view as? SortyCardView {
            switch sender.state {
            case .began:
                self.view.bringSubview(toFront: selectedSortyCardView)
                selectedSortyCardView.contentView.transform = CGAffineTransform.identity.scaledBy(x: SortyCardConstants.scaleCoefficient, y: SortyCardConstants.scaleCoefficient)
            case .changed:
                let translation = sender.translation(in: self.view)
                selectedSortyCardView.center = CGPoint(x: selectedSortyCardView.center.x + translation.x, y: selectedSortyCardView.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: self.view)
            case .ended:
                if let selectedSortyCard = selectedSortyCardView.sortyCard, let selectedSortyCardIndex = deck.index(of: selectedSortyCard) {
                    for index in 0..<deck.count {
                        if let sortyCardView = view.viewWithTag(deck[index].viewTag) as? SortyCardView, sortyCardView.tag != selectedSortyCardView.tag {
                            if let intersectionFrame = sortyCardView.intersectionFrame(requestEntireCard: index == deck.count - 1),
                                let selectedSortyCardIntersectionFrame = selectedSortyCardView.intersectionFrame(requestEntireCard: true),
                                intersectionFrame.intersects(selectedSortyCardIntersectionFrame) {
                                deck.remove(at: selectedSortyCardIndex)

                                if index == 0 {
                                    if let sortyCardView = view.viewWithTag(deck[index + 1].viewTag) as? SortyCardView, sortyCardView.tag != selectedSortyCardView.tag {
                                        if let intersectionFrame = sortyCardView.intersectionFrame(requestEntireCard: false),
                                            let selectedSortyCardIntersectionFrame = selectedSortyCardView.intersectionFrame(requestEntireCard: true),
                                            intersectionFrame.intersects(selectedSortyCardIntersectionFrame) {
                                            deck.insert(selectedSortyCard, at: index + 1)
                                        } else {
                                            deck.insert(selectedSortyCard, at: index)
                                        }
                                    }
                                } else {
                                    if selectedSortyCardIndex < index {
                                        deck.insert(selectedSortyCard, at: index)
                                    } else {
                                        deck.insert(selectedSortyCard, at: index + 1)
                                    }
                                }

                                break
                            }
                        }
                    }
                }

                updateCardPositions(forPanGesture: true)
            default:
                break
            }
        }
    }


    // MARK: - Actions

    @IBAction func randomDeckTapped(_ sender: Any) {
        for index in 0..<deck.count {
            if let sortyCardView = view.viewWithTag(deck[index].viewTag) as? SortyCardView {
                sortyCardView.removeFromSuperview()
            }
        }

        let randomDeck = Array(SortyCard.createFullDeck().shuffled().prefix(SortyCardConstants.cardNumber))

        originalDeck = randomDeck

        initialization()
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

