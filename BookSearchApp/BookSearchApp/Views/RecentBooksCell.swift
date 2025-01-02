//
//  SearchTapCollectionViewCell.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

class RecentBooksCell: UICollectionViewCell {
    static let id = "RecentBooksCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        [
            imageView,
            titleLabel
        ].forEach { contentView.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.height.equalTo(16)
            make.width.equalTo(60)
        }
    }
 }
