//
//  ProductsListViewModel.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import UIKit

// MARK: - ProductsListViewModelDelegate
protocol ProductsListViewModelDelegate: AnyObject {
    func productsFetched()
    func productsAmountChanged()
    func showError(_ error: Error)
}

final class ProductsListViewModel {
    var products: [ProductModel]?
    
    
    weak var delegate: ProductsListViewModelDelegate?
    
    
    var totalPrice: Double? {
        products?.reduce(0) { $0 + $1.price * Double(($1.selectedAmount ?? 0))}
    }
    
    func viewDidLoad() {
        fetchProducts()
        
    }
    
    private func fetchProducts() {
        NetworkManager.shared.fetchProducts { [weak self] response in
            switch response {
            case .success(let products):
                self?.products = products
                self?.delegate?.productsFetched()
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
    
    func removeProduct(at index: Int) {
        
        guard var product = products?[index], let selectedAmount = product.selectedAmount else {
            return
        }
        
        if selectedAmount > 0 {
            product.selectedAmount = selectedAmount - 1
            product.stock += 1
            products?[index] = product
            delegate?.productsAmountChanged()
        }
    }
    func addProduct(at index: Int) {
        
        guard var product = products?[index] else {
            return
        }
        
        if product.stock > 0 {
            product.selectedAmount = (product.selectedAmount ?? 0) + 1
            product.stock -= 1
            products?[index] = product
            delegate?.productsAmountChanged()
        } else {
            print("")
        }
    }
    
}
