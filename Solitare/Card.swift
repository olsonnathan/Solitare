//
//  Card.swift
//  Solitare
//
//  Created by Nathan Olson on 1/8/21.
//

import Foundation

struct Card {
    enum Suit: String, CaseIterable {
        case heart
        case club
        case spade
        case diamond
    }

    enum Rank: String, CaseIterable {
        case ace
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
    }
    
    var suit: Suit
    var rank: Rank
}

extension Card {
    func isRed() -> Bool {
        self.suit == Suit.heart || self.suit == Suit.diamond
    }
    
    func isBlack() -> Bool {
        self.suit == Suit.club || self.suit == Suit.spade
    }
}
