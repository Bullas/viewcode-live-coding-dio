//
//  AutoSizeTableView.swift
//  MazeTv
//
//  Created by Karolina Attekita on 12/02/22.
//

import UIKit

final class AutoSizeTableView: UITableView {
    
    // MARK: - Functions
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
