//
//  Colors.swift
//  MazeTv
//
//  Created by Karolina Attekita on 10/02/22.
//

import Foundation
import UIKit

enum Colors: String {

    case secondary
    case primary
    case background
    case overlay

    var color: UIColor? {
        return UIColor(named: self.rawValue)
    }
}
