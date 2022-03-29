//
//  Service.swift
//  MazeTv
//
//  Created by Karolina Attekita on 10/02/22.
//

import Foundation

protocol ServiceProvider {
    func makeRequest<T: Codable>(endpoint: APIConstants.Endpoints, parameters: [String: String?]?, result: @escaping(Result<T, ServiceError>) -> Void)
}

final class Service: ServiceProvider {

    // MARK: Properties

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "aplication/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return URLSession(configuration: config)
    }()

    func makeRequest<T: Codable>(endpoint: APIConstants.Endpoints, parameters: [String: String?]?, result: @escaping(Result<T, ServiceError>) -> Void) {
        
        guard var components = URLComponents(string: endpoint.urlString) else { return }
        
        components.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data = data
            else {
                result(.failure(ServiceError.badRequest))
                return
            }

            do {
                guard response.statusCode == 200 else {
                    result(.failure(ServiceError.statusCode(response.statusCode)))
                    return
                }
                
                let codable = try JSONDecoder().decode(T.self, from: data)
                result(.success(codable))
            } catch {
                print("Unexpected error: \(error).")
                result(.failure(ServiceError.parseError))
            }
        }
        dataTask.resume()
    }
}
