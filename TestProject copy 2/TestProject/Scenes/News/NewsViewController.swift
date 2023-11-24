//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var news = [News]()
    
    private var viewModel: NewsViewModel = DefaultNewsViewModel()


    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupSubviews()
        setupConstraints()
        setupTableView()
        viewModel.viewDidLoad()
        setupViewModelDelegate()
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
}


// MARK: - TableView DataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell {
            let news = news[indexPath.row]
            cell.configure(with: news)
                           return cell
           
        }
    return UITableViewCell()
    }
}

//"NewsCell"-ის ნაცვლად უნდა იყოს "newsCell"


// MARK: - NewsViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
              DispatchQueue.main.async {
                  self.tableView.reloadData()
              }
    }
    
    func showError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    

}
