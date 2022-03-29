//
//  Grid.swift
//  MazeTv
//
//  Created by Karolina Attekita on 10/02/22.
//

import UIKit

enum Grid {
    case small
    case medium
    case large

    var value: CGFloat {
        switch self {
        case .small:
            return 10
        case .medium:
            return 16
        case .large:
            return 32
        }
    }

    var insets: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        case .medium:
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 15)
        case .large:
            return UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        }
    }
}
