//
//  ProductsListViewController.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import UIKit

final class ProductsListViewController: UIViewController {
    
    // MARK: - UI Components
    private let productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .purple
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .white
        return indicator
    }()
    
    private var totalPriceLbl: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "total: 0$"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private var products = [ProductModel]()
    
    private let productsViewModel = ProductsListViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        setupProductsViewModelDelegate()
        productsViewModel.viewDidLoad()
        
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupBackground()
        setupSubviews()
        setupTableView()
        setupConstraints()
        setupIndicator()
        setupTotalPriceLbl()
    }
    
    private func setupBackground() {
        view.backgroundColor = .orange
    }
    
    private func setupSubviews() {
        view.addSubview(productsTableView)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func setupTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsViewModel.delegate = self
        productsTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    func setupIndicator() {
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupTotalPriceLbl() {
        view.addSubview(totalPriceLbl)
        
        NSLayoutConstraint.activate([
            totalPriceLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalPriceLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalPriceLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    // MARK: - Setup Delegate
    private func setupProductsViewModelDelegate() {
        productsViewModel.delegate = self
    }
}

// MARK: - TableVIew DataSource
extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsViewModel.products?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let currentProduct = productsViewModel.products?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.reload(with: currentProduct)
        return cell
        
    }
    
}



// MARK: - ProductCell Delegate

extension ProductsListViewController: ProductCellDelegate {
    func removeProduct(for cell: ProductCell) {
        if let indexPath = productsTableView.indexPath(for: cell) {
            productsViewModel.removeProduct(at: indexPath.row)
            
        }
    }
    
    func addProduct(for cell: ProductCell) {
        if let indexPath = productsTableView.indexPath(for: cell) {
            productsViewModel.addProduct(at: indexPath.row)
        }
    }
}



// MARK: - TableView Delegate

extension ProductsListViewController: ProductsListViewModelDelegate {
    
    
    func showError(_ error: Error) {
        print("Error: \(error)")
    }
    
    
    func productsAmountChanged() {
        totalPriceLbl.text = "Total price: \(productsViewModel.totalPrice ?? 0)"
        productsTableView.reloadData()
    }
    
    func productsFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.productsTableView.reloadData()
        }
    }
}
