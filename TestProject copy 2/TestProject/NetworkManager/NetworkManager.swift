//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    public static let shared = NetworkManager()
    private let baseURL = "https://newsapi.org/v2"
    private let apiKey =  "ce67ca95a69542b484f81bebf9ad36d5"
    
    private init() {}
    
    func get<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
        }
    }
