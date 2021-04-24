//
//  ScanQRButton.swift
//  LeroyMerlinUITestTask
//
//  Created by Алексей Мотин on 24.04.2021.
//

import UIKit

class ScanQRButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 4
        clipsToBounds = true
        tintColor = .black
        setImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImage () {
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light , scale: .large)
        setImage(UIImage(systemName: "barcode.viewfinder", withConfiguration: configuration), for: .normal)
    }
    
}
