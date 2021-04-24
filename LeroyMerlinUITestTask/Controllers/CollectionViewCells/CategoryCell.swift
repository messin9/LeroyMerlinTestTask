//
//  CategoryCell.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 21.04.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseID = "CategoryCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9403653434, green: 0.9342451484, blue: 0.9532025206, alpha: 1)
        layer.cornerRadius = 4
        clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 0
        title.textAlignment = .left
        return title
    }()
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height / 2),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.height/2),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
