//
//  NewsDetails.swift
//  SparringPal
//
//  Created by Erick Soto on 4/22/23.
//

import Foundation

struct NewsArticle: Codable, Identifiable {
    let id = UUID()
    let title: String
    let url: String
    let urlToImage: String?
}

struct NewsResponse: Codable {
    let articles: [NewsArticle]
}


