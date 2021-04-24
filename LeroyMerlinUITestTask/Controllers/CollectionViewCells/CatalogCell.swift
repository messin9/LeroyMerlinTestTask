//
//  CatalogCell.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 20.04.2021.
//

import UIKit

class CatalogCell: UICollectionViewCell {
    static let reuseID = "CatalogCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGreen
        layer.cornerRadius = 4
        clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Каталог"
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 36)
        imageView.image = UIImage(systemName: "list.bullet", withConfiguration: configuration)
        imageView.tintColor = .white
        return imageView
    }()
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height / 2),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.height/2),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
