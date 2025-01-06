//
//  SavedTapView.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 1/2/25.
//

import UIKit
import SnapKit

final class SavedTapView: UIView {
    
    /// 버튼 클로저
    var deleteButtonPressed: () -> Void =  { }
    var plusButtonPressed: () -> Void =  { }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        
        // 셀 등록
        tableView.register(SavedListCell.self, forCellReuseIdentifier: SavedListCell.id)
        return tableView
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "담은 책"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 버튼 액션
    @objc func deleteButtonTapped() {
        deleteButtonPressed()
    }
    
    // 추가 버튼 눌렸을때
    @objc func plusButtonTapped() {
        plusButtonPressed()
    }
    
    /// 오토레이아웃
    private func configureUI()  {
        
        [
            titleLable,
            deleteButton,
            plusButton,
            tableView
        ].forEach { self.addSubview($0) }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalTo(titleLable)
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(titleLable)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
    }
}
