//
//  RepositTableViewCell.swift
//  MyRepositGitHubUIKit
//
//  Created by Константин Евсюков on 22.09.2023.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
        let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 18)
            return label
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: 300),
            nameLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func configure(myReposit: Repositories) {
        nameLabel.text = myReposit.name
    }
}
