//
//  Article.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

struct Article: Decodable {
    let articles: [News]
}

struct News: Decodable {
    let author: String?
    let title: String?
    let urlToImage: String?
}
