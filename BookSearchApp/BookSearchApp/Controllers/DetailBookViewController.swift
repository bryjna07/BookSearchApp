//
//  DetailBookViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 1/1/25.
//

import UIKit

class DetailBookViewController: UIViewController {
    
    private let detailBookView = DetailBookView()
    
    /// 셀에서 전달받을 BookData 변수
    var bookData: Document? {
        didSet {
            setupBookDatas()
        }
    }
    
    /// 이미지URLString 변수
    var bookImageURL: String? {
        didSet {
            loadImage()
        }
    }
    
    override func loadView() {
        self.view = detailBookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupBookDatas() {
        guard let bookData = self.bookData else { return }
        detailBookView.bookTitleLabel.text = bookData.title
        detailBookView.bookAuthorLabel.text = bookData.authors?.first
        detailBookView.bookPriceLabel.text = "\(bookData.price ?? 0)원"
        detailBookView.bookDescriptionLabel.text = bookData.contents
        
        self.bookImageURL = bookData.thumbnail
            
    }
    
    // MARK: - 디테일 뷰 이미지 로드
    private func loadImage() {
        guard let imageURL = self.bookImageURL, let url = URL(string: imageURL) else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            print("이미지 로드")
            
            DispatchQueue.main.async {
                self?.detailBookView.bookImageView.image = UIImage(data: data)
            }
        }
    }
}
