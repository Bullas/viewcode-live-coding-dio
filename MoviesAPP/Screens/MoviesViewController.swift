//
//  MoviesViewController.swift
//  MoviesAPP
//
//  Created by Karolina Attekita on 28/03/22.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.4
        return image
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(type: MovieCell.self)
        return tableView
    }()
    
    private var movies: [Movie]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let service: MoviesService = MoviesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMovies()
    }
    
    private func fetchMovies() {
        service.fetchList { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response
            case .failure:
                self?.movies = nil
            }
        }
    }
    
    private func searchhMovies(term: String) {
        service.fetchResults(term) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.compactMap({ $0.show })
            case .failure:
                self?.movies = nil
            }
        }
    }
    

    private func setupNavigation() {
        title = "My movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationItem.searchController = searchController
    }
}

extension MoviesViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        setupNavigation()
    }
}


extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueCell(withType: MovieCell.self, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        if let model = movies?[indexPath.row] {
            movieCell.configure(with: model)
        }
        return movieCell
    }
}


// MARK: - Search Bar
extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            fetchMovies()
            return
        }
        searchhMovies(term: searchText)
    }
}
