//
//  NewsTableViewCell.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit


final class NewsTableViewCell: UITableViewCell {
    // ქოლექშენ ვიუ იყო გამოყენებული და შევცვალე და ფექიჯი იყო დაიმპორტირებული და ესეც წავშალე
    
    // MARK: - UI Elements
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 117).isActive = true
        return imageView
    }()
    
    private var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private var newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsTitleLabel, newsAuthorLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsImageView, textStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            newsImageView.widthAnchor.constraint(equalToConstant: 120),
            newsImageView.heightAnchor.constraint(equalToConstant: 117),
            
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textStackView.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    
    // MARK: - Configure
    func configure(with news: News) {
        let url = URL(string: news.urlToImage ?? "")
        newsImageView.kf.setImage(with: url)
        newsTitleLabel.text = news.title
        newsAuthorLabel.text = news.author
    }
}

