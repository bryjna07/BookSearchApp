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
        savedTapView.tableView.delegate = self
    }
    
    /// 버튼 클로저 할당
    func setupButtonAction() {
        
        savedTapView.deleteButtonPressed = { [weak self] in
            guard let self = self else { return }
            
            // 알럿 생성
            let alert = UIAlertController(title: "⚠️ 주의", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
            
            let succes = UIAlertAction(title: "확인", style: .default) { action in
                
                // 코어데이터에서 전체 삭제
                self.coreDataManager.deleteAllBooks {
                    DispatchQueue.main.async {
                        self.savedBooks = []
                        self.savedTapView.tableView.reloadData()
                        print("전체 삭제 완료")
                    }
                }
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(succes)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        savedTapView.plusButtonPressed = { [weak self] in
            guard let self = self else { return }
            
            // 화면 이동
            self.tabBarController?.selectedIndex = 0
            
            // 기존 검색 탭 뷰 컨트롤러의 서치바 활성화
            if let searchVC = self.tabBarController?.viewControllers?.first as? SearchTapViewController {
                searchVC.searchTapView.searchBar.becomeFirstResponder()
            }
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

extension SavedTapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let deleteBook = savedBooks[indexPath.row]
            
            // 배열에서 삭제
            savedBooks.remove(at: indexPath.row)
            
            // 코어데이터에서 삭제
            coreDataManager.deleteBook(with: deleteBook)
            
            // 삭제 애니메이션
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
}
