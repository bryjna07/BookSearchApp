//
//  SectionHeaderView.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let id = "SectionHeader"
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
    
    private func configureUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
        }
    }
}
