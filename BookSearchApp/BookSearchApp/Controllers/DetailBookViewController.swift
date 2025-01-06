//
//  DetailBookViewController.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 1/1/25.
//

import UIKit

protocol SaveBookDelegate: AnyObject {
    func didSaveBook(title: String)
}

final class DetailBookViewController: UIViewController {
    
    weak var delegate: SaveBookDelegate?
    
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
            
            DispatchQueue.main.async {
                self?.detailBookView.bookImageView.image = UIImage(data: data)
            }
        }
    }
    
    // 1. 버튼이 눌렸을 때 클로저 전달(할당)
    private func setupButtonActions() {
        
        detailBookView.saveButtonPressed = { [weak self] in
            guard let self = self, let bookData = self.bookData else { return }
            
            self.coreDataManager.saveBook(with: bookData) { isSaved in
                if isSaved {
                    // 저장 성공 알림
                    self.dismiss(animated: true)
                    self.delegate?.didSaveBook(title: bookData.title ?? "")
                } else {
                    // 중복 데이터 알림
                    self.savedBookAlert(title: bookData.title ?? "")
                }
            }
        }
        
        detailBookView.closeButtonPressed = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    // MARK: - 중복 알럿
    private func savedBookAlert(title: String) {
        let alert = UIAlertController(title: "중복된 책", message: "‘\(title)’ 책은 이미 담겨 있습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
