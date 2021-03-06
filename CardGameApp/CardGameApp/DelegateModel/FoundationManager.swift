//
//  FoundationManager.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 4..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class FoundationManager: FoundationDelegate, Stackable {

    static let range: CountableRange = 0..<4
    private var foundations = [CardStack]()
    var lastCards: [Card?] {
        return foundations.map{ $0.last() }
    }

    init() { //초기상태는 빈 카드스택 4개
        for _ in FoundationManager.range {
            foundations.append(CardStack())
        }
    }

    func stackable(nextCard card: Card) -> Int? {
        if card.isDenominationA() {
            for i in FoundationManager.range where foundations[i].isEmpty() {
                return i
            }
        } else {
            for i in FoundationManager.range where !foundations[i].isEmpty() {
                if foundations[i].last()!.isLower(than: card) {
                    return i
                }
            }
        }
        return nil
    }

    func stackOne(card: Card, column: Int) {
        foundations[column].push(newCard: card)
    }

    private func updateFoundationView() {
        NotificationCenter.default.post(name: .foundationUpdated, object: nil)
    }

    func countOfCards(of column: Int) -> Int {
        return self.foundations[column].count()
    }

    func cardInTurn(at:(column: Int, row: Int)) -> Card {
        return self.foundations[at.column].getCard(at: at.row)
    }

    func cards(in column: Int) -> [Card] {
        return self.foundations[column].getCards()
    }

    func checkFinish() -> Bool {
        return (foundations.filter{ $0.count() == 13 }.count == 4)
    }

}
