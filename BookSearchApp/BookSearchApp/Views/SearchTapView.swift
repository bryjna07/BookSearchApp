//
//  SearchTapView.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import SnapKit

final class SearchTapView: UIView {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "책이름 검색"
        searchBar.searchBarStyle = .default
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 10
        searchBar.layer.borderWidth = 3
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    lazy var searchCollectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: SearchListCell.id)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.id)
        
        
        collectionView.backgroundColor = .white
        return collectionView
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
    
    private func configureUI()  {
        
        [
            searchBar,
            searchCollectionView
        ].forEach { self.addSubview($0) }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(10)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            // leading + trailing = horizontalEdges
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide.snp.horizontalEdges)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
                
            case 0:
                return nil
                
            case 1:
                return self.createSearchListSection()
                
            default:
                return nil
            }
        }
    }
    
    /// 검색결과섹션 레이아웃
    private func createSearchListSection() -> NSCollectionLayoutSection {
        
        // 아이템 크기
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(60)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        // 그룹 크기
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.7)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        // 아이템 사이의 간격
        group.interItemSpacing = .fixed(10)
        group.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 0)
        
        // 섹션
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // 헤더 추가
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}




@available(iOS 17.0, *)
#Preview {
    SearchTapViewController()
}
