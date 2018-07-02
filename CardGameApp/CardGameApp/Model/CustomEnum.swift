//
//  CustomEnum.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 17..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import UIKit

enum PositionX: EnumCollection {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh

    var value: CGFloat {
        switch self {
        case .first: return 6.46875
        case .second: return 64.6875
        case .third: return 122.90625
        case .fourth: return 181.125
        case .fifth: return 239.34375
        case .sixth: return 297.5625
        case .seventh: return 355.78125
        }
    }

}

enum PositionY {
    case upper
    case bottom

    var value: CGFloat {
        switch self {
        case .upper: return 20
        case .bottom: return 100
        }
    }
}


enum StackTable: Int {
    case first = 1
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
}

enum ViewKey {
    case deck
    case stack
    case fromStack
    case foundation
}

enum Key {
    case FromView
    case GestureRecognizer
}

enum FinishAlert: CustomStringConvertible {
    case GameSuccess
    case SuccessAlertMessage
    case YAY
    case DefaultAction
    case AlertLog

    var description: String {
        switch self {
        case .GameSuccess:
            return "Game Success"
        case .SuccessAlertMessage:
            return "Congratulations!🎉\nTap 'YAY' to restart a game!"
        case .YAY:
            return "YAY!🤩"
        case .DefaultAction:
            return "Default action"
        case .AlertLog:
            return "User tapped \"YAY!\"button."
        }
    }
}
