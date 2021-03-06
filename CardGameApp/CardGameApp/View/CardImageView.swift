//
//  CardImageMaker.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    private var imageName: String!
    private var card: ImageSelector?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(_:)))
        self.addGestureRecognizer(panGesture)
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
    }

    func getImage(of card: ImageSelector) {
        self.card = card
        if card.image == "card-back" {
            self.getDeckImage()
            self.isUserInteractionEnabled = false
        } else {
            self.image = UIImage(named: "card_decks/\(card.image).png")
            self.imageName = card.image
        }
    }

    func getDeckImage() {
        self.image = UIImage(named: "card-back")
    }

    func getRefreshImage() {
        self.image = UIImage(named: "cardgameapp-refresh-app")
    }

    @objc func cardDragged(_ sender: UIPanGestureRecognizer) {
        NotificationCenter.default.post(name: .cardDragged, object: self, userInfo: [Key.GestureRecognizer:sender])
    }


}
