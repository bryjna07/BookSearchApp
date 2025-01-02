//
//  StoreListViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

final class SavedTapViewController: UIViewController {
    
    private let savedTapView = SavedTapView()
    
    var savedBooks: [BookSaved] = []
    
    let coreDataManager = CoreDataManager.shared
    
    override func loadView() {
        self.view = savedTapView
    }
    
    // 뷰가 나타날때마다
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 코어데이터에 저장된 데이터 불러오기
        savedBooks = coreDataManager.getBookSavedArrayFromCoreData()
        savedTapView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAction()
        savedTapView.tableView.dataSource = self
    }
    
    /// 버튼 클로저 할당
    func setupButtonAction() {
        
//        savedTapView.deleteButtonPressed = { [weak self] in
//
//            
//        }
//        
//        savedTapView.plusButtonPressed = { [weak self] in
//          
//            
//        }
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
