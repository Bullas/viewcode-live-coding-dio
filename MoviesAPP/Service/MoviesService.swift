//
//  MoviesService.swift
//  MoviesAPP
//
//  Created by Karolina Attekita on 28/03/22.
//

import Foundation

final class MoviesService {
    
    // MARK: Properties

    private let service: ServiceProvider
    
    // MARK: Init's

    init(service: ServiceProvider = Service()) {
        self.service = service
    }
    
    func fetchResults(_ search: String, result: @escaping (Result<SearchShowResponse, ServiceError>) -> Void) {
        let parameters = ["q": search]
        service.makeRequest(endpoint: .search, parameters: parameters) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
    
    func fetchList(result:  @escaping(Result<ShowResponse, ServiceError>) -> Void) {
        service.makeRequest(endpoint: .shows, parameters: nil) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
}
