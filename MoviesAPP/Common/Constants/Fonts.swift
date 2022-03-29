//
//  Fonts.swift
//  MazeTv
//
//  Created by Karolina Attekita on 10/02/22.
//

import Foundation
import UIKit

enum Fonts {

    case small(UIFont.Weight)
    case medium(UIFont.Weight)
    case large(UIFont.Weight)

    var font: UIFont {
        switch self {
        case .small(let weight):
            return UIFont.systemFont(ofSize: 12, weight: weight)
        case .medium(let weight):
            return UIFont.systemFont(ofSize: 18, weight: weight)
        case .large(let weight):
            return UIFont.systemFont(ofSize: 28, weight: weight)
        }
    }
}
