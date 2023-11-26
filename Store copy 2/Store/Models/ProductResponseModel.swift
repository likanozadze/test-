//
//  ProductResponseModel.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import Foundation

struct ProductResponseModel: Decodable {
    var products: [ProductModel]
    var total: Int
    let skip: Int
    let limit: Int
}
