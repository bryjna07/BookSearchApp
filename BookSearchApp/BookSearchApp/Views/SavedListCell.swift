//
//  StoreListCell.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

final class SavedListCell: UITableViewCell {
    
    static let id = "SavedListCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        return view
    }()
    
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // 셀 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(26)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        
        [
            bookNameLabel,
            authorNameLabel,
            bookPriceLabel
        ].forEach { containerView.addSubview($0) }
        
        bookNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(bookNameLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        bookPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(authorNameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}
