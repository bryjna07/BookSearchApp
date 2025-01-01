//
//  DetailBookViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 1/1/25.
//

import UIKit

class DetailBookViewController: UIViewController {
    
    private let detailBookView = DetailBookView()
    
    let coreDataManager = CoreDataManager.shared
    
    /// 셀에서 전달받을 BookData 변수
    var bookData: Document? {
        didSet {
            setupBookDatas()
        }
    }
    
    override func loadView() {
        self.view = detailBookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonActions()
    }
    
    private func setupBookDatas() {
        guard let bookData = self.bookData else { return }
        detailBookView.bookTitleLabel.text = bookData.title
        detailBookView.bookAuthorLabel.text = bookData.authors?.first
        detailBookView.bookPriceLabel.text = "\(bookData.price ?? 0)원"
        detailBookView.bookDescriptionLabel.text = bookData.contents
        
        loadImage(with: bookData.thumbnail)
            
    }
    
    // MARK: - 디테일 뷰 이미지 로드
    private func loadImage(with imageUrl: String?) {
        guard let urlString = imageUrl, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            print("이미지 로드")
            
            DispatchQueue.main.async {
                self?.detailBookView.bookImageView.image = UIImage(data: data)
            }
        }
    }
    
    // 1. 버튼이 눌렸을 때 클로저 전달(할당)
    private func setupButtonActions() {
        
        detailBookView.saveButtonPressed = { [weak self] in
               guard let bookData = self?.bookData else { return }
               self?.coreDataManager.saveBook(with: bookData) {
                   print("저장완료")
                   self?.dismiss(animated: true)
               }
           }
           
        detailBookView.closeButtonPressed = { [weak self] in
            self?.dismiss(animated: true)
           }
       }
}
