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
    
    func testSort123WithSampleDeck_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.sampleDeck) else {
            XCTFail("123 sort testing is failed for sample deck.")
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
        
        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sort testing is failed for sample deck.")
    }
    
    func testSort123WithDeck1_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.deck1) else {
            XCTFail("123 sort testing is failed for deck 1.")
            return
        }
        
        let correct123SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .two, type: .hearts),
                                           SortyCard(rank: .three, type: .hearts),
                                           SortyCard(rank: .four, type: .hearts),
                                           SortyCard(rank: .five, type: .hearts),
                                           SortyCard(rank: .six, type: .hearts),
                                           SortyCard(rank: .seven, type: .hearts),
                                           SortyCard(rank: .eight, type: .hearts)],
                                          [SortyCard(rank: .jack, type: .hearts),
                                           SortyCard(rank: .queen, type: .hearts),
                                           SortyCard(rank: .king, type: .hearts)], []]
        
        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sort testing is failed for deck 1.")
    }
    
    func testSort123WithDeck2_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.deck2) else {
            XCTFail("123 sort testing is failed for deck 2.")
            return
        }
        
        let correct123SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .two, type: .hearts),
                                           SortyCard(rank: .three, type: .hearts),
                                           SortyCard(rank: .four, type: .hearts),
                                           SortyCard(rank: .five, type: .hearts),
                                           SortyCard(rank: .six, type: .hearts),
                                           SortyCard(rank: .seven, type: .hearts),
                                           SortyCard(rank: .eight, type: .hearts),
                                           SortyCard(rank: .nine, type: .hearts),
                                           SortyCard(rank: .ten, type: .hearts),
                                           SortyCard(rank: .jack, type: .hearts)], []]
        
        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sort testing is failed for deck 2.")
    }
    
    func testSort123WithDeck3NoMatch_success() {
        let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.deck3)
        
        XCTAssertEqual(sortResult, nil, "123 sort testing is failed for deck 3.")
    }
    
    func testSort123WithDeck4_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.deck4) else {
            XCTFail("123 sort testing is failed for deck 4.")
            return
        }
        
        let correct123SortedCardGroups = [[SortyCard(rank: .ace, type: .diamonds),
                                           SortyCard(rank: .two, type: .diamonds),
                                           SortyCard(rank: .three, type: .diamonds),
                                           SortyCard(rank: .four, type: .diamonds)],
                                          [SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .jack, type: .spades),
                                           SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .jack, type: .hearts),
                                           SortyCard(rank: .jack, type: .diamonds),
                                           SortyCard(rank: .ace, type: .clubs),
                                           SortyCard(rank: .jack, type: .clubs)]]
        
        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sort testing is failed for deck 4.")
    }
    
    func testSort123WithDeck6_15cards_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.deck6) else {
            XCTFail("123 sort testing is failed for deck 6.")
            return
        }
        
        let correct123SortedCardGroups = [[SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .two, type: .spades),
                                           SortyCard(rank: .three, type: .spades),
                                           SortyCard(rank: .four, type: .spades)],
                                          [SortyCard(rank: .ace, type: .diamonds),
                                           SortyCard(rank: .two, type: .diamonds),
                                           SortyCard(rank: .three, type: .diamonds),
                                           SortyCard(rank: .four, type: .diamonds)],
                                          [SortyCard(rank: .ace, type: .clubs),
                                           SortyCard(rank: .two, type: .clubs),
                                           SortyCard(rank: .three, type: .clubs),
                                           SortyCard(rank: .four, type: .clubs)],
                                          [SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .two, type: .hearts),
                                           SortyCard(rank: .four, type: .hearts)]]
        
        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sort testing is failed for deck 6.")
    }
    
    func testSort123WithDeck7_7cards_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort123, deck: TestDecks.deck7) else {
            XCTFail("123 sort testing is failed for deck 7.")
            return
        }
        
        let correct123SortedCardGroups = [[SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .two, type: .spades),
                                           SortyCard(rank: .three, type: .spades)],
                                          [SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .two, type: .diamonds),
                                           SortyCard(rank: .ace, type: .clubs),
                                           SortyCard(rank: .three, type: .clubs)]]
        
        XCTAssertEqual(sortResult, correct123SortedCardGroups, "123 sort testing is failed for deck 7.")
    }
    
    func testSort777WithSampleDeck_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort777, deck: TestDecks.sampleDeck) else {
            XCTFail("777 sort testing is failed for sample deck.")
            return
        }
        
        let correct777SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .ace, type: .diamonds)],
                                          [SortyCard(rank: .four, type: .hearts),
                                           SortyCard(rank: .four, type: .clubs),
                                           SortyCard(rank: .four, type: .spades),
                                           SortyCard(rank: .four, type: .diamonds)],
                                          [SortyCard(rank: .two, type: .spades),
                                           SortyCard(rank: .five, type: .diamonds),
                                           SortyCard(rank: .three, type: .diamonds),
                                           SortyCard(rank: .three, type: .spades)]]
        
        XCTAssertEqual(sortResult, correct777SortedCardGroups, "777 sort testing is failed for sample deck.")
    }
    
    func testSort777WithDeck4_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort777, deck: TestDecks.deck4) else {
            XCTFail("777 sort testing is failed for deck 4.")
            return
        }
        
        let correct777SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .ace, type: .diamonds),
                                           SortyCard(rank: .ace, type: .clubs)],
                                          [SortyCard(rank: .jack, type: .spades),
                                           SortyCard(rank: .jack, type: .diamonds),
                                           SortyCard(rank: .jack, type: .clubs),
                                           SortyCard(rank: .jack, type: .hearts)],
                                          [SortyCard(rank: .two, type: .diamonds),
                                           SortyCard(rank: .three, type: .diamonds),
                                           SortyCard(rank: .four, type: .diamonds)]]
        
        XCTAssertEqual(sortResult, correct777SortedCardGroups, "777 sort testing is failed for deck 4.")
    }
    
    func testSort777WithDeck2NoMatch_success() {
        let sortResult = CardSorter.sort(sortingType: .sort777, deck: TestDecks.deck2)
        
        XCTAssertEqual(sortResult, nil, "777 sort testing is failed for deck 2.")
    }
    
    func testSort777WithDeck5_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort777, deck: TestDecks.deck5) else {
            XCTFail("777 sort testing is failed for deck 5.")
            return
        }
        
        let correct777SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .ace, type: .diamonds),
                                           SortyCard(rank: .ace, type: .clubs)],
                                          [SortyCard(rank: .jack, type: .spades),
                                           SortyCard(rank: .jack, type: .diamonds),
                                           SortyCard(rank: .jack, type: .clubs),
                                           SortyCard(rank: .jack, type: .hearts)],
                                          [SortyCard(rank: .king, type: .diamonds),
                                           SortyCard(rank: .king, type: .spades),
                                           SortyCard(rank: .king, type: .clubs)], []]
        
        XCTAssertEqual(sortResult, correct777SortedCardGroups, "777 sort testing is failed for deck 5.")
    }
    
    func testSort777WithDeck6_15cards_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort777, deck: TestDecks.deck6) else {
            XCTFail("777 sort testing is failed for deck 6.")
            return
        }
        
        let correct777SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .ace, type: .diamonds),
                                           SortyCard(rank: .ace, type: .clubs)],
                                          [SortyCard(rank: .two, type: .spades),
                                           SortyCard(rank: .two, type: .diamonds),
                                           SortyCard(rank: .two, type: .clubs),
                                           SortyCard(rank: .two, type: .hearts)],
                                          [SortyCard(rank: .three, type: .diamonds),
                                           SortyCard(rank: .three, type: .spades),
                                           SortyCard(rank: .three, type: .clubs)],
                                          [SortyCard(rank: .four, type: .hearts),
                                           SortyCard(rank: .four, type: .diamonds),
                                           SortyCard(rank: .four, type: .spades),
                                           SortyCard(rank: .four, type: .clubs)], []]
        
        XCTAssertEqual(sortResult, correct777SortedCardGroups, "777 sort testing is failed for deck 6.")
    }
    
    func testSort777WithDeck7_7cards_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sort777, deck: TestDecks.deck7) else {
            XCTFail("777 sort testing is failed for deck 7.")
            return
        }
        
        let correct777SortedCardGroups = [[SortyCard(rank: .ace, type: .hearts),
                                           SortyCard(rank: .ace, type: .spades),
                                           SortyCard(rank: .ace, type: .clubs)],
                                          [SortyCard(rank: .two, type: .diamonds),
                                           SortyCard(rank: .two, type: .spades),
                                           SortyCard(rank: .three, type: .spades),
                                           SortyCard(rank: .three, type: .clubs)]]
        
        XCTAssertEqual(sortResult, correct777SortedCardGroups, "777 sort testing is failed for deck 7.")
    }
    
    func testSortSmartWithSampleDeck_success() {
        guard let sortResult = CardSorter.sort(sortingType: .sortSmart, deck: TestDecks.sampleDeck) else {
            XCTFail("Smart sort testing is failed for sample deck.")
            return
        }
        
        let correctSmartSortedCardGroups = [[SortyCard(rank: .ace, type: .spades),
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
        
        XCTAssertEqual(sortResult, correctSmartSortedCardGroups, "Smart sort testing is failed for sample deck.")
    }
    
}
