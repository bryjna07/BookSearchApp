//
//  ViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit

class SearchTapViewController: UIViewController {
    
    let searchTapView = SearchTapView()
    
    let networkManager = NetworkManager.shared
    
    var bookArrays: [Document] = []
    
    var recentBookArrays: [Document] = []
    
    var recentBooks: Document? {
        didSet {
            configureWithRecentBooks()
        }
    }
    
    override func loadView() {
        self.view = searchTapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 최근검색 섹션이 없을 때 관련
        searchTapView.recentBooksCountHandler = { [weak self] in
            return self?.recentBookArrays.count ?? 0
        }
        
        searchTapView.searchCollectionView.delegate = self
        searchTapView.searchCollectionView.dataSource = self
        searchTapView.searchBar.delegate = self
    }
    
    // didSelectItemAt 누르면 recentBooks 에서 didSet 실행
    private func configureWithRecentBooks() {
        guard let book = self.recentBooks else { return }
        self.recentBookArrays.insert(book, at: 0)
        if self.recentBookArrays.count > 10 {
            self.recentBookArrays.removeLast()
        }
        self.searchTapView.searchCollectionView.reloadData()
    }
    
    // 바깥 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SearchTapViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return recentBookArrays.count
        } else {
            return bookArrays.count
        }
    }
    
    // 섹션별 셀 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBooksCell.id, for: indexPath) as! RecentBooksCell
            
            cell.titleLabel.text = recentBookArrays[indexPath.row].title
            
            // 셀 색상 배열 정의
            let colors: [UIColor] = [
                .systemRed, .systemOrange, .systemYellow, .systemGreen,
                .systemBlue, .systemMint, .systemPink , .systemPurple,
                .systemBrown, .systemGray2
            ]
            
            let colorIndex = indexPath.row % colors.count
            cell.imageView.backgroundColor = colors[colorIndex]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.id, for: indexPath) as! SearchListCell
            
            cell.bookNameLabel.text = bookArrays[indexPath.row].title
            cell.authorNameLabel.text = bookArrays[indexPath.row].authors?.first
            cell.bookPriceLabel.text = "\(bookArrays[indexPath.row].price ?? 0)원"
            
            cell.layer.borderWidth = 2
            return cell
        }
    }
    
    // 섹션에 따른 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeader.id,
            for: indexPath
        ) as! SectionHeader
        
        switch indexPath.section {
        case 0:
            header.label.text = "최근 본 책"
        case 1:
            header.label.text = "검색 결과"
        default:
            break
        }
        return header
    }
}

extension SearchTapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailBookViewController()
        
        // 알럿 delegate 설정
        detailVC.delegate = self
        
        switch indexPath.section {
        case 0:
            return
        case 1:
            detailVC.bookData = bookArrays[indexPath.row]
            self.recentBooks = bookArrays[indexPath.row]
        default:
            return
        }
        
        present(detailVC, animated: true, completion: nil)
    }
}

extension SearchTapViewController: UISearchBarDelegate {
    
    // 입력 시작되었을 때 키보드
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    // 검색버튼 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchTapView.searchBar.text else { return }
        self.view.endEditing(true)
        print(text)
        
        // 빈배열로 다시 만들어줌
        self.bookArrays = []
        
        // 서치바에 입력된 텍스트로 네트워킹 시작
        networkManager.fetchBooks(searchTerm: text) { result in
            switch result {
            case .success(let bookDatas):
                self.bookArrays = bookDatas
                DispatchQueue.main.async { [weak self] in
                    self?.searchTapView.searchCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

/// 알럿 delegate 프로토콜
extension SearchTapViewController: SaveBookDelegate {
    func didSaveBook(title: String) {
        
        let alert = UIAlertController(title: nil, message: "‘\(title)’ 책 담기 완료!", preferredStyle: .alert)
        
               alert.addAction(UIAlertAction(title: "확인", style: .default))
        
               present(alert, animated: true, completion: nil)
    }
}
