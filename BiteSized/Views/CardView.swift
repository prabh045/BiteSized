//
//  CardView.swift
//  BiteSized
//
//  Created by Prabhdeep Singh on 04/09/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "Yolo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        
        addSubview(idLabel)
        addSubview(descriptionLabel)
        setUpLayout()
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    
}
