//
//  ViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit

class SearchTapViewController: UIViewController {
    
    private let searchTapView = SearchTapView()
    
    override func loadView() {
        self.view = searchTapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTapView.searchCollectionView.delegate = self
        searchTapView.searchCollectionView.dataSource = self
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
                return 5
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentBooksCell.id, for: indexPath) as! RecentBooksCell
            
                     return cell
                 } else {
                     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCell.id, for: indexPath) as! SearchListCell
                     
                     cell.layer.borderWidth = 3
                     return cell
                 }
             }
       
       
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
    
}

