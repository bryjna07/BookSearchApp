//
//  DetailBookView.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

final class DetailBookView: UIView {
    
    // 2. 뷰컨에 있는 클로저 저장(할당)
    var saveButtonPressed: () -> Void =  { }
    var closeButtonPressed: () -> Void =  { }
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector (closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - 생성자 셋팅
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 3. 버튼이 눌리면 ButtonPressed 에 들어있는 클로저 실행
    @objc func saveButtonTapped(_ sender: UIButton) {
        saveButtonPressed()
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        closeButtonPressed()
    }
    
    private func configureUI() {
        
        [
            bookTitleLabel,
            bookAuthorLabel,
            bookImageView,
            bookPriceLabel,
            bookDescriptionLabel,
            saveButton,
            closeButton
        ].forEach { self.addSubview($0) }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        bookAuthorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints { make in
            make.top.equalTo(bookAuthorLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(360)
        }
        
        bookPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        bookDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(bookPriceLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.equalTo(closeButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}
