//
//  CardDeck.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class CardDeck {
    private var cards = [Card]()

    init() {
        var cards = [Card]()
        for shape in Suit.allValues {
            for number in Denomination.allValues {
                cards.append(Card(suit: shape, denomination: number))
            }
        }
        self.cards = cards
    }
    
    func reset() -> CardDeck {
        return CardDeck()
    }

    func shuffleDeck(with cards: [Card]) {
        self.cards += cards
        shuffle()
    }

    func shuffle() {
        var tempCards = self.cards
        var shuffledCards = [Card]()
        
        while 0 < tempCards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(tempCards.count)))
            let pickedCard = tempCards.remove(at: randomIndex)
            shuffledCards.append(pickedCard)
        }
        self.cards = shuffledCards
    }
    
    func removeOne() -> Card {
        let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
        let pickedCard = self.cards.remove(at: randomIndex)
        return pickedCard
    }

    func removeLast() -> Card {
        let lastCard = self.cards.removeLast()
        return lastCard
    }

    func count() -> Int {
        return self.cards.count
    }

    func makeCards(_ countOfCards: Int) -> [Card] {
        var cards = [Card]()
        for _ in 0..<countOfCards {
            let picked = removeOne()
            cards.append(picked)
        }
        return cards
    }

    func makeStack(numberOf countOfCards: Int) -> CardStack {
        var cards = [Card]()
        for _ in 0..<countOfCards {
            let picked = removeOne()
            cards.append(picked)
        }
        return CardStack(cards)
    }

    func hasEnoughCards(numberOfNeeded: Int) -> Bool {
        if numberOfNeeded < self.cards.count {
            return true
        }
        return false
    }

}

extension CardDeck {
    
    enum Suit: String, Comparable, CustomStringConvertible {
        case heart = "♥️"
        case diamond = "♦️"
        case clover = "♣️"
        case spade = "♠️"

        var description: String {
            switch self {
            case .heart, .diamond: return "red"
            case .clover, .spade: return "black"
            }
        }

        static func <(lhs: CardDeck.Suit, rhs: CardDeck.Suit) -> Bool {
            return lhs.hashValue < rhs.hashValue
        }

        static func ==(lhs: CardDeck.Suit, rhs: CardDeck.Suit) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }

        static var allValues: [Suit] = [.heart, .diamond, .clover, .spade]

    }
    
    enum Denomination: Int, CustomStringConvertible, Comparable {
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .eleven: return "J"
            case .twelve: return "Q"
            case .thirteen: return "K"
            default: return String(self.rawValue)
            }
        }

        static func <(lhs: CardDeck.Denomination, rhs: CardDeck.Denomination) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        static func ==(lhs: CardDeck.Denomination, rhs: CardDeck.Denomination) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }

        func isContinuous(next: CardDeck.Denomination) -> Bool {
            return self.rawValue == (next.rawValue + 1)
        }

        func isDescending(next: CardDeck.Denomination) -> Bool {
            return self.rawValue == (next.rawValue - 1)
        }

        static var allValues: [Denomination] = [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .eleven, .twelve, .thirteen]
    }
   
}

    

