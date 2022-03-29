//
//  Errors.swift
//  MazeTv
//
//  Created by Karolina Attekita on 10/02/22.
//

import Foundation

enum ServiceError: Error {
    case parseError
    case statusCode(Int)
    case badRequest
}
