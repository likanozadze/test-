//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation
import Kingfisher
//ფექიჯი არ იყო დაიმპორტებული ვიუმოდელში

protocol NewsViewModelDelegate: AnyObject {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

protocol NewsViewModel {
    var delegate: NewsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultNewsViewModel: NewsViewModel {
    private var newsList = [News]()
    private let networkManager: NetworkManager
    
    weak var delegate: NewsViewModelDelegate?
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    
    // MARK: - Public Methods
    func viewDidLoad() {
        fetchNews()
    }
    
    
    // MARK: - Private Methods
    
    private func fetchNews() {
        let fullURL = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-11&sortBy=publishedAt&apiKey=ce67ca95a69542b484f81bebf9ad36d5"
        NetworkManager.shared.get(url: fullURL) { [weak self] (result: Result<Article, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let article):
                self.delegate?.newsFetched(article.articles)
                self.newsList.append(contentsOf: article.articles)
            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
}
