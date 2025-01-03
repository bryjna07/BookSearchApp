//
//  SearchListCell.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

class SearchListCell: UICollectionViewCell {
    
    static let id = "SearchListCell"
    
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            bookNameLabel,
            authorNameLabel,
            bookPriceLabel
        ].forEach { contentView.addSubview($0) }
        
        bookNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(contentView.snp.centerX).offset(10)
            make.centerY.equalToSuperview()
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(bookNameLabel.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
        }
        
        bookPriceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
}
