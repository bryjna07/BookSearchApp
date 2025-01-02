//
//  ViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit

class SearchTapViewController: UIViewController {
    
    private let searchTapView = SearchTapView()
    
    let networkManager = NetworkManager.shared
    
    var bookArrays: [Document] = []
    
    override func loadView() {
        self.view = searchTapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTapView.searchCollectionView.delegate = self
        searchTapView.searchCollectionView.dataSource = self
        searchTapView.searchBar.delegate = self
    }
}

extension SearchTapViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return bookArrays.count
        }
    }
    
    // 섹션별 셀 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBooksCell.id, for: indexPath) as! RecentBooksCell
            
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
        
        switch indexPath.section {
        case 0:
            return
        case 1:
            detailVC.bookData = bookArrays[indexPath.row]
        default:
            return
        }
        
        present(detailVC, animated: true, completion: nil)
    }
}

extension SearchTapViewController: UISearchBarDelegate {
    
    // 검색버튼 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchTapView.searchBar.text else { return }
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
