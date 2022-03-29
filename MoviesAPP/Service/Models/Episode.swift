//
//  Episode.swift
//  MazeTv
//
//  Created by Karolina Attekita on 12/02/22.
//

import Foundation

// MARK: - EpisodeElement
struct Episode: Codable {
    let id: Int
    let name: String?
    let season, number: Int?
    let image: Image?
    let summary: String?
}

struct Season: Codable {
    let number: Int?
    let episodes: [Episode]?
}
