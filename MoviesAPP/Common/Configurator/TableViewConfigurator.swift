//
//  TableViewConfigurator.swift
//  MazeTv
//
//  Created by Karolina Attekita on 11/02/22.
//

import Foundation
import UIKit
import SwiftUI

// MARK: Section
struct TableViewSectionViewModel {
    let title: String?
    var rows: [TableViewCellViewModelProtocol]
}

// MARK: Cell View Model
protocol TableViewCellViewModelProtocol {}

// MARK: Cell View Model
protocol TableViewCellProtocol where Self: UITableViewCell  {
    func load(viewModel: TableViewCellViewModelProtocol)
}

// MARK: TableView Configurator
protocol TableViewConfiguratorProtocol: NSObject {
    associatedtype Cell
    var source: [TableViewSectionViewModel]? { get }
    var target: UITableView? { get }
    var onSelected: ((IndexPath) -> Void)? { get set }
    func load(source: [TableViewSectionViewModel])
}

typealias TableViewConfiguratorType = NSObject & TableViewConfiguratorProtocol & UITableViewDataSource & UITableViewDelegate

final class TableViewConfigurator<Cell: TableViewCellProtocol>: TableViewConfiguratorType {
    
    // MARK: Properties

    private(set) var source: [TableViewSectionViewModel]?
    private(set) weak var target: UITableView?
    var onSelected: ((IndexPath) -> Void)?

    // MARK: Init

    init(target: UITableView) {
        self.target = target
        super.init()
        self.target?.dataSource = self
        self.target?.delegate = self
        self.target?.registerCell(type: Cell.self)
    }

    func load(source: [TableViewSectionViewModel]) {
        self.source = source
        target?.reloadData()
    }
    
    // MARK: DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        source?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        source?[section].rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: Cell.self) as? TableViewCellProtocol,
              let viewModel = source?[indexPath.section].rows[indexPath.row] else { return UITableViewCell() }
        
        cell.load(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        source?[section].title
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelected?(indexPath)
    }
}
