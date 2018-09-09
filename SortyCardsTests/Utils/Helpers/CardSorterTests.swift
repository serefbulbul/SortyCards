//
//  CardSorterTests.swift
//  SortyCardsTests
//
//  Created by Seref Bulbul on 8.09.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

@testable import SortyCards

import XCTest

class CardSorterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSort123WithSampleDeck() {
        let sampleDeck = [SortyCard(rank: .ace, type: .hearts),
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

        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: sampleDeck) else {
            XCTFail("123 sorting is wrong for sample deck.")
            return
        }

        let correct123SortedCardGroups = [[SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .two, type: .spades),
                                           SortyCard(rank: .three, type: .spades),
                                           SortyCard(rank: .four, type: .spades)],
                                          [SortyCard(rank: .three, type: .diamonds),
                                           SortyCard(rank: .four, type: .diamonds),
                                           SortyCard(rank: .five, type: .diamonds)],
                                          [SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .four, type: .hearts),
                                           SortyCard(rank: .ace, type: .diamonds),
                                           SortyCard(rank: .four, type: .clubs)]]

        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sorting is wrong for sample deck.")
    }

}
