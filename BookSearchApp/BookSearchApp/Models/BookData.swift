//
//  BookData.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import Foundation

// MARK: - BookData
struct BookData: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]?
    let contents: String?
    let price: Int?
    let publisher: String?
    let thumbnail: String?
    let title: String?
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool?
    let pageableCount, totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
