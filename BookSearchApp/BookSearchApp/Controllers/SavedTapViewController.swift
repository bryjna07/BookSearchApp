//
//  StoreListViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

final class SavedTapViewController: UIViewController {
    
    var savedBooks: [BookSaved] = []
    
    let coreDataManager = CoreDataManager.shared
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        
        // 셀 등록
        tableView.register(SavedListCell.self, forCellReuseIdentifier: SavedListCell.id)
        return tableView
    }()
    
    // 뷰가 나타날때마다
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 코어데이터에 저장된 데이터 불러오기
        savedBooks = coreDataManager.getBookSavedArrayFromCoreData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SavedTapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedListCell.id, for: indexPath) as! SavedListCell
        
        let bookSaved = savedBooks[indexPath.row]
        cell.bookNameLabel.text = bookSaved.title
        cell.authorNameLabel.text = bookSaved.authors
        cell.bookPriceLabel.text = bookSaved.price
        
        cell.selectionStyle = .none
        
        return cell
    }
}
