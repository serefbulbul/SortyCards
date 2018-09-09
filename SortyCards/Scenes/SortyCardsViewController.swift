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

    private var originalDeck = [SortyCard]()
    private var deck = [SortyCard]()
    private var cardBeginningPosition = CGRect.zero
    private var cardPositions = [CGPoint]()

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        originalDeck = sampleDeck

        initialization()
    }

    // MARK: - Business

    private func initialization() {
        deck = originalDeck

        cardBeginningPosition = CGRect(x: (view.frame.size.width - SortyCardConstants.cardWidth) / 2, y: view.frame.size.height, width: SortyCardConstants.cardWidth, height: SortyCardConstants.cardHeight)
        
        calculateCardPositions()
        updateCardPositions(forCardDistirution: true)
    }

    func calculateCardPositions() {
        let slice = (SortyCardConstants.endAngle - SortyCardConstants.startAngle) * CGFloat.pi / CGFloat(deck.count - 1)

        cardPositions = (0..<deck.count).map({ index -> CGPoint in
            let angle = (slice * CGFloat(index)) + (SortyCardConstants.startAngle * .pi)
            let x = SortyCardConstants.arcCenter.x + SortyCardConstants.arcRadius * cos(angle)
            let y = SortyCardConstants.arcCenter.y + SortyCardConstants.arcRadius * sin(angle)
            
            return CGPoint(x: x, y: y)
        })
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
        for index in 0..<deck.count {
            let position = cardPositions[index]
            let cardToPosition = CGRect(x: position.x - (SortyCardConstants.cardWidth / 2), y: position.y - (SortyCardConstants.cardHeight / 2), width: SortyCardConstants.cardWidth, height: SortyCardConstants.cardHeight)

            var sortyCardView = view.viewWithTag(deck[index].viewTag) as? SortyCardView

            if sortyCardView == nil {
                sortyCardView = SortyCardView(frame: cardBeginningPosition, sortyCard: deck[index])
            }

            if let sortyCardView = sortyCardView {
                var animationDuration = 0.0

                if forCardDistirution {
                    sortyCardView.isUserInteractionEnabled = true
                    sortyCardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
                    
                    animationDuration = SortyCardConstants.distributionAnimationDuration
                    randomDeckButton.isEnabled = false
                } else if forPanGesture {
                    sortyCardView.removeFromSuperview()
                    animationDuration = SortyCardConstants.panGestureAnimationDuration
                } else {
                    sortyCardView.removeFromSuperview()
                    animationDuration = SortyCardConstants.sortAnimationDuration
                }
                
                view.addSubview(sortyCardView)

                UIView.animate(withDuration: animationDuration, delay: forCardDistirution ? Double(index) * SortyCardConstants.distributionAnimationDuration : 0, options: [], animations: {
                    sortyCardView.frame = cardToPosition
                    
                    sortyCardView.contentView.transform = CGAffineTransform.identity.rotated(by: .pi * (0.5 + SortyCardConstants.startAngle + (SortyCardConstants.endAngle - SortyCardConstants.startAngle) * CGFloat(index) / CGFloat(self.deck.count)))
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
