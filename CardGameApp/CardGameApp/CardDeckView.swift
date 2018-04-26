//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 24..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardDeckView: UIView {

    var gameManager: CardGameManageable?
    var cardMaker: CardFrameManageable?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(cardMaker: CardFrameManageable, gameManager: CardGameManageable) {
        self.init(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
        self.cardMaker = cardMaker
        self.gameManager = gameManager
    }

    func drawDefault() {
        guard let cardDeck = self.gameManager else { return }
        guard let cardFrameMaker = self.cardMaker else { return }

        let deckButtonFrame = cardFrameMaker.cardFrame(x: 6, y: PositionY.upper.value)
        let cardDeckView = CardImageView(frame: deckButtonFrame)

        if cardDeck.hasEnoughCard() {
            cardDeckView.getDeckImage()
            addSubview(cardDeckView)
        } else {
            cardDeckView.getRefreshImage()
            addSubview(cardDeckView)
        }
    }

}
