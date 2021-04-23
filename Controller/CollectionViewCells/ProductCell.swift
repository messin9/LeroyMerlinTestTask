//
//  ProductCell.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 21.04.2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
    static let reuseID = "ProductCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        backgroundColor = .white
        clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var productImageView: UIImageView = {
        let productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        return productImage
    }()
    
    lazy var productPriceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textAlignment = .left
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return priceLabel
    }()
    
    lazy var productNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    private func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(productImageView)
        addSubview(productPriceLabel)
        addSubview(productNameLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            productImageView.heightAnchor.constraint(equalToConstant: self.frame.width - 10)
        ])
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
        ])
    }
    
    
    func cacheImage (with model: SectionModel, placeholder: UIImage? = nil, cache: URLCache = URLCache.shared ) {
        let imageUrl = "https://picsum.photos/seed/picsum/350/350"
        guard let url = URL(string: imageUrl) else { return }
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self .productImageView.image = image
            return
        }
        let placeholder = UIImage(systemName: "exclamationmark.icloud.fill")
        self.productImageView.image = placeholder
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let response = response,
                ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                let image = UIImage(data: data)
            else { return }
            let cachedData = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedData, for: request)
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }.resume()
    }
}
